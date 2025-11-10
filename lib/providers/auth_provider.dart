import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gicc/services/admin_service.dart';
import 'package:gicc/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  final AuthServices _authService = AuthServices();
  final AdminService _adminService = AdminService();
  User? _user;
  User? get user => _user;
  AdminUser? _adminUser;
  AdminUser? get adminUser => _adminUser;

  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailRegController = TextEditingController();
  final TextEditingController passwordRegController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();

  Future<void> signIn(context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        await _authService.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Welcome back! Signed in successfully.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        String errorMessage = _getReadableErrorMessage(e.code);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An unexpected error occurred. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        log('Sign in error: $e');
      }
    }
  }

  String _getReadableErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No account found with this email address. Please check your email or contact support.';
      case 'wrong-password':
        return 'Incorrect password. Please try again or use "Forgot Password" to reset it.';
      case 'invalid-email':
        return 'The email address format is invalid. Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support for assistance.';
      case 'too-many-requests':
        return 'Too many failed login attempts. Please wait a few minutes and try again.';
      case 'invalid-credential':
        return 'Invalid email or password. Please check your credentials and try again.';
      case 'email-already-in-use':
        return 'This email address is already registered. Please sign in instead.';
      case 'weak-password':
        return 'Password is too weak. Please use at least 6 characters with a mix of letters and numbers.';
      case 'network-request-failed':
        return 'Network connection failed. Please check your internet connection and try again.';
      default:
        return 'Login failed. Please check your email and password and try again.';
    }
  }

  Future<void> registerUser(context, {AdminRole role = AdminRole.admin}) async {
    try {
      if (formKeyRegister.currentState?.validate() ?? false) {
        // Check if current user is super admin
        final isSuperAdmin = await _adminService.isSuperAdmin();
        if (!isSuperAdmin) {
          throw Exception('Only super admins can create new admin users');
        }

        // Create Firebase Auth user
        final userCredential =
            await _authService.createUserWithEmailAndPassword(
                email: emailRegController.text.trim(),
                password: passwordRegController.text);

        // Create admin entry in Firestore
        if (userCredential.user != null) {
          await _adminService.createAdminEntry(
            uid: userCredential.user!.uid,
            email: emailRegController.text.trim(),
            role: role,
          );
        }

        notifyListeners();

        // Clear the form
        emailRegController.clear();
        passwordRegController.clear();

        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Admin user created successfully!\nRole: ${role == AdminRole.superAdmin ? 'Super Admin' : 'Regular Admin'}',
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
            ),
          );
        }
        log('Admin created: ${emailRegController.text}');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getRegistrationErrorMessage(e.code);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      log('Error creating admin: ${e.code}');
      rethrow;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating admin: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      log('Error creating admin: ${emailRegController.text}');
      rethrow;
    }
  }

  /// Get user-friendly error messages for registration errors
  String _getRegistrationErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'An account with this email already exists. Please use a different email address.';
      case 'invalid-email':
        return 'The email address format is invalid. Please enter a valid email address.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password with at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support.';
      case 'network-request-failed':
        return 'Network connection failed. Please check your internet connection and try again.';
      default:
        return 'Failed to create admin user. Please try again or contact support.';
    }
  }

  Future<void> resetPassword(context) async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter your email to reset password')),
      );
      return;
    }
    try {
      await _authService.resetPassword(
        email: emailController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${e.toString()} An error occurred')),
      );
      rethrow;
      // log('${e.message}');
    }
  }

  /// Reset password with email parameter - used by LoginDialog
  Future<void> resetPasswordWithEmail(
      BuildContext context, String email) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    try {
      await _authService.resetPassword(email: email.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Password reset email sent! Please check your inbox and follow the instructions.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 4),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getPasswordResetErrorMessage(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'An unexpected error occurred. Please try again. Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  /// Get user-friendly error messages for password reset errors
  String _getPasswordResetErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address format is invalid. Please enter a valid email address.';
      case 'user-not-found':
        return 'No account found with this email address. Please check your email or create a new account.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support for assistance.';
      case 'too-many-requests':
        return 'Too many password reset requests. Please wait a few minutes and try again.';
      case 'network-request-failed':
        return 'Network connection failed. Please check your internet connection and try again.';
      default:
        return 'Failed to send password reset email. Please try again or contact support.';
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _adminUser = null;
    notifyListeners();
  }

  void _onAuthStateChanged(User? user) async {
    _user = user;

    // Load admin user data if user is logged in
    if (user != null) {
      _adminUser = await _adminService.getCurrentAdminUser();
    } else {
      _adminUser = null;
    }

    notifyListeners();
  }
}
