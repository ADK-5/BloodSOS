// ignore_for_file: file_names

import 'package:blood_donation/Auth%20pages/SignIn.dart';
import 'package:blood_donation/Auth%20pages/SignUp.dart';
import 'package:blood_donation/Auth%20pages/registrationPage.dart';
import 'package:blood_donation/auth.dart';
import 'package:blood_donation/dtbase.dart';
import 'package:blood_donation/providers/newUserCheckProvider.dart';
import 'package:blood_donation/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          Auth().authStateChanges.listen((User? user) {
            if (user == null) {
              if (kDebugMode) {
                print("No user");
              }
            } else {
              context.read<NewUserChecker>().newUserCheck(user.uid);
              if (kDebugMode) {
                //print("User ${user.uid} is signed In");
              }
            }
          });
          if (snapshot.hasData) {
            return context.watch<NewUserChecker>().isNew
                ? RegisterUser()
                : MyHomePage();
          } else {
            return const AuthServices();
          }
        });
  }
}

class AuthServices extends StatefulWidget {
  const AuthServices({Key? key}) : super(key: key);

  @override
  State<AuthServices> createState() => _AuthServicesState();
}

class _AuthServicesState extends State<AuthServices> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginPage(
            onSignup: toggle,
          )
        : SignupPage(
            onLogin: toggle,
          );
  }

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
