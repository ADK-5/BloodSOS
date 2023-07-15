// ignore_for_file: file_names, non_constant_identifier_names

import 'package:blood_donation/auth.dart';
import 'package:blood_donation/commons/fieldStyle.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onLogin;
  const SignupPage({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _controllerEmail=TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controllerEmail,
              decoration: TextFormFieldStyle.copyWith(labelText: "Email"),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: true,
              controller: _controllerPassword,
              decoration: TextFormFieldStyle.copyWith(
                labelText: "Password",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Auth().createUserwithEmailandPassword(
                      email: _controllerEmail.text,
                      password: _controllerPassword.text);
                },
                child: const Text("Sign In")),
            ElevatedButton(
                onPressed: () {
                  Auth().signInWithGoogle();
                },
                child: const Text("Sign in with Google")),
            ElevatedButton(
                onPressed: widget.onLogin,
                child: const Text("Log In Instead")),
          ],
        ),
      ),
    );
  }
}
