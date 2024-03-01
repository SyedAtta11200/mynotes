// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mynotes/firebase_options.dart';
// import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routs.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification(email: email);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  "Weak password try again!",
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  "Email already in use!",
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  'Invalid email!',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  "An error occurred, try again!",
                );
              }
            },
            child: const Text("Register"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("Already registered? Login here!"),
          )
        ],
      ),
    );
  }
}
