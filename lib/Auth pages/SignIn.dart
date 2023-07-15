// ignore_for_file: file_names

import 'package:blood_donation/auth.dart';
import 'package:blood_donation/commons/fieldStyle.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onSignup;
  const LoginPage({Key? key, required this.onSignup}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controlllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
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
              controller: _controlllerPassword,
              decoration: TextFormFieldStyle.copyWith(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () {
                  Auth().signInwithEmailandPassword(
                      email: _controllerEmail.text,
                      password: _controlllerPassword.text);
                },
                child: const Text("Sign In")),
            ElevatedButton(
                onPressed: () {
                  Auth().signInWithGoogle();
                },
                child: Text("Sign in with Google")),
            ElevatedButton(
                onPressed: widget.onSignup,
                child: const Text("Sign Up Instead")),
          ],
        ),
      ),
    );
  }
}
