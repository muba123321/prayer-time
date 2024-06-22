import 'package:flutter/material.dart';
import 'package:gicc/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  RegisterDialogState createState() => RegisterDialogState();
}

class RegisterDialogState extends State<RegisterDialog> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return AlertDialog(
      title: const Text('Register New Admin'),
      content: Form(
        key: authProvider.formKeyRegister,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: authProvider.emailRegController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: authProvider.passwordRegController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => authProvider.registerUser(context),
          child: const Text('Register'),
        ),
      ],
    );
  }
}
