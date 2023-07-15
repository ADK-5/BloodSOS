import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../auth.dart';

class NewUserChecker with ChangeNotifier{
  late bool _new=true;
  bool get isNew=>_new;

  Future<void> newUserCheck() async {
    var id = Auth().currentUser?.uid;
    final allProfiles = await FirebaseFirestore.instance.collection("Profiles").get();
    for (var users in allProfiles.docs) {
      if (id == users.id) {
        _new=false;
        notifyListeners();
        break;
      }
    }
  }

  void toggleUserUniqueness(){
    _new=!_new;
  }
}
