import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dbms {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future createUser({
    //String collectionPath="Profiles",
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
        return SnackBar(content: Text("Created user in db"));
      });
    } catch (e) {
      return SnackBar(content: Text("error"));
    }
    ;
  }
}
