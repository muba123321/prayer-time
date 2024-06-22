import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gicc/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  final AuthServices _authService = AuthServices();
  User? _user;
  User? get user => _user;

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
            email: emailController.text, password: passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admin user logged in Successfully')),
        );

        Navigator.of(context).pop();
        notifyListeners();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${e.toString()} An error occurred')),
        );
        // log('${e}');
        rethrow;
      }
    }
  }

  Future<void> registerUser(context) async {
    try {
      if (formKeyRegister.currentState?.validate() ?? false) {
        await _authService.createUserWithEmailAndPassword(
            email: emailRegController.text,
            password: passwordRegController.text);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admin user created successfully')),
        );
        log(emailRegController.text);
        log(passwordRegController.text);
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${e.toString()} An error occurred')),
      );
      log('adsadsdsd ${emailRegController.text}');
      log(passwordRegController.text);
      rethrow;
      // log('${e.message}');
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

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }
}
