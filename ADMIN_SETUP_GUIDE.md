# Admin Setup Guide

## 🚀 Initial Setup - Creating First Super Admin

Since we now have Firestore security rules that require a super admin to create other admins, you need to create the first super admin manually.

### Option 1: Using Firebase Console (Recommended)

1. **Create User in Firebase Authentication**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Select your project: `gicc-f1622`
   - Navigate to **Authentication** → **Users**
   - Click **Add User**
   - Enter email and password
   - Copy the **User UID** (you'll need this)

2. **Create Admin Entry in Firestore**
   - Navigate to **Firestore Database**
   - Click **Start Collection**
   - Collection ID: `admins`
   - Document ID: Paste the **User UID** from step 1
   - Add the following fields:
     ```
     email: (string) "your-email@example.com"
     role: (string) "super_admin"
     createdBy: (string) "system"
     createdAt: (timestamp) [Auto-generated]
     ```
   - Click **Save**

### Option 2: Using Flutter App (One-Time)

Add this code temporarily to your `main.dart` after Firebase initialization:

```dart
// In main() function, after Firebase.initializeApp()

// TEMPORARY: Initialize first super admin - REMOVE AFTER FIRST RUN
final adminService = AdminService();
final auth = FirebaseAuth.instance;

// Create the user first through Firebase Console or here
// Then uncomment and run this once:
/*
if (auth.currentUser != null) {
  await adminService.initializeFirstSuperAdmin(
    auth.currentUser!.uid,
    auth.currentUser!.email!,
  );
  print('First super admin initialized!');
}
*/
```

### Option 3: One-Time Setup Screen (Best for Development)

I can create a one-time setup screen that:
1. Shows only if no admins exist in Firestore
2. Allows creating the first super admin
3. Disables itself after first admin is created

Would you like me to create this?

## 📋 Firestore Security Rules Deployment

### Deploy the rules:

1. **Install Firebase CLI** (if not already installed):
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Initialize Firebase in your project** (if not already done):
   ```bash
   cd /Users/chambas/Documents/FlutterProjects/islamic_center_prayer_times
   firebase init firestore
   ```
   - Select your project: `gicc-f1622`
   - Use `firestore.rules` as the rules file
   - Use `firestore.indexes.json` for indexes

4. **Deploy the rules**:
   ```bash
   firebase deploy --only firestore:rules
   ```

### Verify deployment:

1. Go to Firebase Console
2. Navigate to **Firestore Database** → **Rules**
3. You should see the rules we created

## 🔐 Testing the Security

### Test 1: Super Admin Can Create Admins
1. Log in with your super admin account
2. Try to create a new admin user
3. Should succeed ✅

### Test 2: Regular Admin Cannot Create Admins
1. Create a regular admin (role: 'admin') using super admin
2. Log out and log in as regular admin
3. Try to create a new admin user
4. Should show "Access Denied" message ✅

### Test 3: Firestore Rules Working
1. Try to create admin document directly without proper role
2. Should be blocked by Firestore rules ✅

## 📱 Current Role Structure

### Super Admin
- Can create new admins
- Can modify prayer times and events
- Can view all admins
- Can update/delete admin accounts

### Regular Admin  
- Can modify prayer times and events
- Cannot create new admins
- Cannot modify other admin accounts

## 🔄 Creating More Admins

After the first super admin is set up:

1. Log in as super admin
2. Go to Profile screen
3. Click "Create New Admin"
4. Acknowledge security notice
5. Enter email and password
6. New admin will be created with 'admin' role by default

## 🎯 Next Steps

1. ✅ Deploy Firestore rules to Firebase
2. ✅ Create first super admin user
3. ✅ Test admin creation flow
4. ✅ Verify security rules are working
5. Optional: Add admin management screen to view/edit all admins

## ⚙️ Advanced: Admin Management (Future Enhancement)

Would you like me to create:
- Admin list screen showing all admins?
- Ability to promote admin to super admin?
- Admin activity logs?
- Admin account suspension feature?

Let me know which features you'd like to add!
