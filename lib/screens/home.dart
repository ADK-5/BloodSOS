import 'package:blood_donation/auth.dart';
import 'package:blood_donation/commons/fieldStyle.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:blood_donation/dtbase.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                Auth().signOut();
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
    );
  }
}
