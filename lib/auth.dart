
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Auth{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges{
    return _firebaseAuth.authStateChanges();
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
    }) async{
      var userdata;
      try{
        userdata=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      }catch(e) {
        if (kDebugMode) {
          print(e);
        }
      }
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
}