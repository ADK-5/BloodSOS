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
        return const SnackBar(content: Text("Created user in db"));
      });
    } catch (e) {
      return const SnackBar(content: Text("error"));
    }
  }

  Future createRequest({
    required String req_blood_group,
    required int req_units,
    required String state,
    required String city,
}) {
    // TODO: implement createRequest
    throw UnimplementedError();
  }
}
