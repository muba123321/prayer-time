import 'package:flutter/material.dart';
import 'package:gicc/providers/auth_provider.dart';
import 'package:gicc/widgets/auth_widgets/registrationdialog.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  LoginDialogState createState() => LoginDialogState();
}

class LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthProvider>(context);
    return AlertDialog(
      title: const Text('Login'),
      content: Form(
        key: authNotifier.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: authNotifier.emailController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            TextFormField(
              controller: authNotifier.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            TextButton(
                onPressed: () => authNotifier.resetPassword(context),
                child: const Text('Forgot email,username or password?')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const RegisterDialog();
                    },
                  );
                },
                child: const Text('create a new user admin'))
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => authNotifier.signIn(context),
          child: const Text('Login'),
        ),
      ],
    );
  }
}
