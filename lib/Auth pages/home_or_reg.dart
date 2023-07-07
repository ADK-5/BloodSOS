import 'package:blood_donation/Auth%20pages/registration.dart';
import 'package:blood_donation/auth.dart';
import 'package:blood_donation/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeorReg extends StatefulWidget {
  const HomeorReg({Key? key}) : super(key: key);

  @override
  State<HomeorReg> createState() => _HomeorRegState();
}

class _HomeorRegState extends State<HomeorReg> {
  //var currUser=Auth().currentUser;
  var dbUser = FirebaseFirestore.instance
      .collection("Profiles")
      .doc(Auth().currentUser?.uid);
  late bool isReg;

  @override
  Widget build(BuildContext context) {
    dbUser.get().then((DocumentSnapshot doc) {

    });
    return isReg
        ? const RegistrationPage(
            //onSignup: toggle,
            )
        : const MyHomePage(
            //onLogin: toggle,
            );
  }

  // void toggle() {
  //   setState(() {
  //     isLogin = !isLogin;
  //   });
  // }
}
