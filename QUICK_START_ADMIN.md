# 🚀 Quick Start: Create First Admin

## Step 1: Deploy Firestore Rules (5 minutes)

```bash
cd /Users/chambas/Documents/FlutterProjects/islamic_center_prayer_times
./deploy-firestore-rules.sh
```

Or manually:
```bash
firebase login
firebase use gicc-f1622
firebase deploy --only firestore:rules
```

## Step 2: Create First Super Admin via Firebase Console (2 minutes)

### A. Create User in Firebase Authentication

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select project: **gicc-f1622**
3. Click **Authentication** in left sidebar
4. Click **Users** tab
5. Click **Add User** button
6. Enter:
   - **Email**: `your-admin-email@example.com`
   - **Password**: Choose a strong password (min 6 characters)
7. Click **Add User**
8. **IMPORTANT**: Copy the **User UID** (you'll need this next)
   - Example: `xKj8mP2QvNZYR4tG9hL5wC3bF1aE`

### B. Create Admin Document in Firestore

1. Click **Firestore Database** in left sidebar
2. Click **Start Collection** (or if collections exist, click **Add Collection**)
3. Collection ID: `admins`
4. Click **Next**
5. Document ID: **Paste the User UID you copied** (e.g., `xKj8mP2QvNZYR4tG9hL5wC3bF1aE`)
6. Add these fields:

| Field | Type | Value |
|-------|------|-------|
| email | string | `your-admin-email@example.com` |
| role | string | `super_admin` |
| createdBy | string | `system` |
| createdAt | timestamp | Click **Generate** or use current time |

7. Click **Save**

## Step 3: Test Your Admin Account (1 minute)

1. Open your Flutter app
2. Go to **Profile** screen
3. Click **"Sign In as Admin"**
4. Enter the email and password you created
5. Click **Login**
6. ✅ You should now see the **Admin Panel** section
7. ✅ You can now create additional admins!

---

## 🎯 That's It!

Your first super admin is ready. You can now:
- ✅ Log in as admin
- ✅ Create more admin users
- ✅ Manage prayer times
- ✅ Manage events

---

## 📋 Quick Reference

### Admin Roles

**Super Admin** (`role: "super_admin"`):
- Create/delete other admins
- Full access to all features

**Regular Admin** (`role: "admin"`):  
- Manage prayer times and events
- Cannot create other admins

### Create More Admins (After First Setup)

1. Log in as super admin
2. Go to Profile screen
3. Click "Create New Admin"
4. Enter email and password
5. Done! (New admin will have regular admin role by default)

### Promote Admin to Super Admin

Go to Firestore Console:
1. Navigate to `admins` collection
2. Click on the admin's document
3. Edit the `role` field
4. Change from `"admin"` to `"super_admin"`
5. Save

---

## ⚠️ Important Notes

- **Save your super admin credentials** in a secure place
- **Don't share super admin account** - create separate accounts for other admins
- **Regular admins** can modify app content but cannot create new admins
- **Only super admins** can create other admin accounts

---

## 🔧 Troubleshooting

### "Access Denied" when trying to create admin
**Solution**: Make sure your Firestore rules are deployed and you're logged in as a super admin.

### Can't see Admin Panel after login
**Solution**: Check that your user has a document in the `admins` collection in Firestore.

### Forgot admin password
**Solution**: Use Firebase Console → Authentication → Find user → Reset password.

---

## 🎉 Success Checklist

- [ ] Firestore rules deployed
- [ ] First super admin created in Firebase Console
- [ ] Admin document created in Firestore `admins` collection
- [ ] Tested login in app
- [ ] Can see Admin Panel
- [ ] Can create additional admins

**You're all set!** 🚀
