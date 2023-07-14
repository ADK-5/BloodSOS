// ignore_for_file: non_constant_identifier_names

import 'package:blood_donation/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DB {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future createUser({
    required String documentID,
    required String name,
    required String phoneNo,
    required String dateOfBirth,
  }) async {
    final docUser = _db.collection("Profiles").doc(documentID);
    final json = {
      'name': name,
      'dateOfBirth': dateOfBirth,
      'Phone No.': phoneNo,
    };
    try {
      await docUser.set(json).whenComplete(() {
        return const SnackBar(content: Text("Created user in db"));
      });
    } catch (e) {
      return const SnackBar(content: Text("error"));
    }
  }

  Future createRequest({
    required String req_blood_group,
    required String req_units,
    required String state,
    required String city,
    bool IsResolved = false,
  }) async {
    final application = _db.collection("Requests").doc();
    final json2 = {
      "Blood Group": req_blood_group,
      "Units": req_units,
      "State": state,
      "City": city,
      "Resolved": IsResolved,
      "Requested On": DateTime.now(),
      "Resolved On": "",
      "Request uid": Auth().currentUser?.uid,
    };
    try {
      await application
          .set(json2)
          .whenComplete(() => const SnackBar(content: Text("Request created")));
    } catch (e) {
      return const SnackBar(content: Text("Some error occured"));
    }
  }

  Future
  <bool>
  isNewUser() async {
    var id=Auth().currentUser?.uid;
    final allProfiles= await _db.collection("Profiles").get();
    for (var users in allProfiles.docs){
      // print("id: $id");
      // print(users.id);
      if(id==users)return false;
    }
    return true;
  }



}
