import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

enum AdminRole {
  admin,
  superAdmin,
}

class AdminUser {
  final String uid;
  final String email;
  final AdminRole role;
  final String createdBy;
  final DateTime createdAt;

  AdminUser({
    required this.uid,
    required this.email,
    required this.role,
    required this.createdBy,
    required this.createdAt,
  });

  bool get canCreateAdmins => role == AdminRole.superAdmin;

  factory AdminUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AdminUser(
      uid: doc.id,
      email: data['email'] ?? '',
      role: data['role'] == 'super_admin'
          ? AdminRole.superAdmin
          : AdminRole.admin,
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'role': role == AdminRole.superAdmin ? 'super_admin' : 'admin',
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if current user is an admin
  Future<bool> isAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    try {
      final doc = await _firestore.collection('admins').doc(user.uid).get();
      return doc.exists;
    } catch (e) {
      log('Error checking admin status: $e');
      return false;
    }
  }

  // Check if current user is a super admin
  Future<bool> isSuperAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    try {
      final doc = await _firestore.collection('admins').doc(user.uid).get();
      if (!doc.exists) return false;

      final data = doc.data();
      return data?['role'] == 'super_admin';
    } catch (e) {
      log('Error checking super admin status: $e');
      return false;
    }
  }

  // Get current admin user details
  Future<AdminUser?> getCurrentAdminUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      final doc = await _firestore.collection('admins').doc(user.uid).get();
      if (!doc.exists) return null;

      return AdminUser.fromFirestore(doc);
    } catch (e) {
      log('Error getting admin user: $e');
      return null;
    }
  }

  // Create admin entry in Firestore after user creation
  Future<void> createAdminEntry({
    required String uid,
    required String email,
    required AdminRole role,
  }) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('Not authenticated');
    }

    // Check if current user is super admin
    final canCreate = await isSuperAdmin();
    if (!canCreate) {
      throw Exception('Only super admins can create new admins');
    }

    final adminUser = AdminUser(
      uid: uid,
      email: email,
      role: role,
      createdBy: currentUser.uid,
      createdAt: DateTime.now(),
    );

    try {
      await _firestore
          .collection('admins')
          .doc(uid)
          .set(adminUser.toFirestore());

      log('Admin entry created successfully for $email');
    } catch (e) {
      log('Error creating admin entry: $e');
      rethrow;
    }
  }

  // Get all admins (for super admins)
  Future<List<AdminUser>> getAllAdmins() async {
    final canView = await isSuperAdmin();
    if (!canView) {
      throw Exception('Only super admins can view all admins');
    }

    try {
      final snapshot = await _firestore
          .collection('admins')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => AdminUser.fromFirestore(doc)).toList();
    } catch (e) {
      log('Error getting all admins: $e');
      rethrow;
    }
  }

  // Update admin role (super admin only)
  Future<void> updateAdminRole({
    required String uid,
    required AdminRole newRole,
  }) async {
    final canUpdate = await isSuperAdmin();
    if (!canUpdate) {
      throw Exception('Only super admins can update admin roles');
    }

    try {
      await _firestore.collection('admins').doc(uid).update({
        'role': newRole == AdminRole.superAdmin ? 'super_admin' : 'admin',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      log('Admin role updated successfully');
    } catch (e) {
      log('Error updating admin role: $e');
      rethrow;
    }
  }

  // Delete admin entry (super admin only)
  Future<void> deleteAdmin(String uid) async {
    final currentUser = _auth.currentUser;
    if (currentUser?.uid == uid) {
      throw Exception('Cannot delete your own admin account');
    }

    final canDelete = await isSuperAdmin();
    if (!canDelete) {
      throw Exception('Only super admins can delete admins');
    }

    try {
      await _firestore.collection('admins').doc(uid).delete();
      log('Admin deleted successfully');
    } catch (e) {
      log('Error deleting admin: $e');
      rethrow;
    }
  }

  // Initialize first super admin (call this once during setup)
  Future<void> initializeFirstSuperAdmin(String uid, String email) async {
    try {
      // Check if any admins exist
      final snapshot = await _firestore.collection('admins').limit(1).get();

      if (snapshot.docs.isEmpty) {
        // No admins exist, create first super admin
        final adminUser = AdminUser(
          uid: uid,
          email: email,
          role: AdminRole.superAdmin,
          createdBy: 'system',
          createdAt: DateTime.now(),
        );

        await _firestore
            .collection('admins')
            .doc(uid)
            .set(adminUser.toFirestore());

        log('First super admin initialized: $email');
      } else {
        log('Admins already exist, cannot initialize');
      }
    } catch (e) {
      log('Error initializing first super admin: $e');
      rethrow;
    }
  }
}
