import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

String path =
    "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries%2Bstates%2Bcities.json";

class dropdowns with ChangeNotifier {
  Map<String, int> StateAndIndex = {};
  List<String> StateOnly = [];

  void getStates() async {
    var response = await Dio().get(path);
    if (response.statusCode == 200) {
      String responseBody = response.data;
      var responseJson = jsonDecode(responseBody);
      //101 is index for India
      // print(responseJson[101]['states']);
      responseJson[101]['states'].forEach((var st) {
        StateOnly.add(st['name']);
        StateAndIndex[st['name']] = StateAndIndex.length;
        //print(StateAndIndex);
      });
      //print(responseJson[101]['states'][0]['cities']);// cities list of Andaman and Nicobar Islands
    }
  }
}


