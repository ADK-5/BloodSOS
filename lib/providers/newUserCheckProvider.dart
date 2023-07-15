import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NewUserChecker with ChangeNotifier{
  late bool _new=true;
  bool get isNew=>_new;

  Future<void> newUserCheck(String uid) async {
    bool check=true;
    final allProfiles = await FirebaseFirestore.instance.collection("Profiles").get();
    for (var userdocs in allProfiles.docs) {
      if (uid == userdocs.id) {
        if (kDebugMode) {
          //print("Found object");
        }
         check=false;
        break;
      }
      if (kDebugMode) {
        print("user id: ${userdocs.id}");
      }
    }
    if(check) {
      _new=true;
    } else {
      _new=false;
    }
    notifyListeners();
  }

  void toggleUserUniqueness(){
    _new=!_new;
    notifyListeners();
  }
}
