import 'package:blood_donation/dtbase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }

  String? returnuid(){
    return currentUser?.uid;
  }

  Future<void> signInwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future createUserwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    var userdata;
    try {
      userdata = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential user = await _firebaseAuth.signInWithCredential(credential);
    final additionalUserInfo = user.additionalUserInfo;
    if (kDebugMode && additionalUserInfo != null) {
      /*{given_name: A D, locale: en-GB, family_name: K,
      picture: https://lh3.googleusercontent.com/a/AAcHTtdtTjSVdh0pHL6b4g6lm2mWxBKiOgnC_SAImXPT9R1V=s96-c,
      aud: 143292030531-cfp3ahckqh3ple8ir18l5v97p6k2p4hh.apps.googleusercontent.com,
      azp: 143292030531-pmaa3do1h8iikvqk79j1nojl8kijifn8.apps.googleusercontent.com,
      exp: 1689345244, iat: 1689341644, iss: https://accounts.google.com, sub: 111200449011335343176,
      name: A D K, email: adkcoc1@gmail.com, email_verified: true}
*/
      // if (additionalUserInfo.isNewUser) {
      //   DB().createUser(
      //       documentID: additionalUserInfo.providerId!,
      //       name: additionalUserInfo.profile!['name'],
      //       phoneNo: "phoneNo",
      //       dateOfBirth: "dateOfBirth");
      // }
      print(additionalUserInfo.profile);
      print("id: ${additionalUserInfo.providerId}");
    } else if (kDebugMode) {
      print("object");
    }
  }
}
