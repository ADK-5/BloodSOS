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
      appBar: AppBar(title: Text("Sign In")),
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextFormField(
              controller: _controllerEmail,
              decoration: TextFormFieldStyle.copyWith(labelText: "Email"),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _controlllerPassword,
              decoration: TextFormFieldStyle.copyWith(
                labelText: "Password",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Auth().signInwithEmailandPassword(
                      email: _controllerEmail.text,
                      password: _controlllerPassword.text);
                },
                child: Text("Sign In")),
            ElevatedButton(onPressed: widget.onSignup, child: Text("Sign Up Instead")),
          ],
        ),
      ),
    );
  }
}
