# Security Guide for Admin User Creation

## ⚠️ Current Security Status

**Issue**: Currently, any authenticated admin can create new admin users through the app UI.

**Risk Level**: Medium - While the UI is protected (only logged-in users see the button), there's no restriction on WHO can create admins.

## 🔒 Recommended Security Layers

### 1. **UI Level Protection** ✅ (Already Implemented)
The "Create New Admin" button only appears when a user is logged in:
```dart
if (notifier.user != null) _buildAdminSection(context, notifier)
```

### 2. **Firebase Security Rules** (REQUIRED - Not Yet Implemented)

#### For Firestore (if storing user roles):
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Admin users collection
    match /admins/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
                      get(/databases/$(database)/documents/admins/$(request.auth.uid)).data.role == 'super_admin';
    }
  }
}
```

#### For Firebase Authentication:
- By default, Firebase Auth allows any authenticated user to access the SDK
- You MUST use **Firebase Admin SDK** on a backend server to properly control user creation

### 3. **Backend API Solution** (BEST PRACTICE)

Create a Cloud Function to handle admin creation:

```javascript
// functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.createAdmin = functions.https.onCall(async (data, context) => {
  // Check if request is made by authenticated user
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  // Check if the user is a super admin
  const userDoc = await admin.firestore()
    .collection('admins')
    .doc(context.auth.uid)
    .get();
  
  if (!userDoc.exists || userDoc.data().role !== 'super_admin') {
    throw new functions.https.HttpsError('permission-denied', 'Only super admins can create new admins');
  }

  // Create the new admin user
  try {
    const newUser = await admin.auth().createUser({
      email: data.email,
      password: data.password,
    });

    // Add user to admins collection with role
    await admin.firestore().collection('admins').doc(newUser.uid).set({
      email: data.email,
      role: data.role || 'admin',
      createdBy: context.auth.uid,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true, uid: newUser.uid };
  } catch (error) {
    throw new functions.https.HttpsError('internal', error.message);
  }
});
```

### 4. **App-Level Role Management** (Recommended)

Add a role system to distinguish between regular admins and super admins:

```dart
// Create a UserRole enum
enum UserRole {
  superAdmin,
  admin,
  user,
}

// Store role in Firestore when user is created
class AdminUser {
  final String uid;
  final String email;
  final UserRole role;
  final DateTime createdAt;
  
  // Only super admins can create other admins
  bool get canCreateAdmins => role == UserRole.superAdmin;
}
```

## 🚀 Implementation Steps

### Option A: Simple (UI + Firestore Rules)
1. ✅ Keep current UI protection
2. Add Firestore collection to track admin roles
3. Implement Firestore Security Rules
4. Check role before showing "Create Admin" button

### Option B: Secure (Backend + Firestore)
1. ✅ Keep current UI protection
2. Create Firebase Cloud Function for user creation
3. Add role management in Firestore
4. Update app to call Cloud Function instead of direct auth

### Option C: Quick Fix (Disable Registration)
1. Remove the "Create New Admin" feature entirely
2. Create all admin users through Firebase Console
3. Simplest but least flexible

## 📋 Current Quick Fix

For immediate security, I recommend:

1. **Disable the registration dialog** for now
2. **Create admin users manually** through Firebase Console
3. **Implement proper backend** solution later

## 🔐 Firestore Security Rules Template

Add this to your `firestore.rules` file:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper function to check if user is admin
    function isAdmin() {
      return request.auth != null && 
             exists(/databases/$(database)/documents/admins/$(request.auth.uid));
    }
    
    // Helper function to check if user is super admin
    function isSuperAdmin() {
      return request.auth != null && 
             get(/databases/$(database)/documents/admins/$(request.auth.uid)).data.role == 'super_admin';
    }
    
    // Admin users collection
    match /admins/{userId} {
      allow read: if isAdmin();
      allow create: if isSuperAdmin();
      allow update, delete: if isSuperAdmin();
    }
    
    // Prayer times (example)
    match /prayer_times/{document=**} {
      allow read: if true; // Public read
      allow write: if isAdmin(); // Only admins can modify
    }
    
    // Events
    match /events/{document=**} {
      allow read: if true;
      allow write: if isAdmin();
    }
  }
}
```

## 🎯 Recommended Action NOW

I can implement one of these options:

1. **Add a super admin check** - Only first admin can create others
2. **Disable the feature** - Remove "Create Admin" button entirely
3. **Add warning** - Keep it but show security warning

Which would you prefer?
