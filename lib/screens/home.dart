import 'package:blood_donation/auth.dart';
import 'package:blood_donation/dtbase.dart';
import 'package:blood_donation/fcm.dart';
import 'package:blood_donation/providers/newUserCheckProvider.dart';
import 'package:blood_donation/screens/all_requests.dart';
import 'package:blood_donation/screens/requestPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void requestBlood() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 350,
            padding: const EdgeInsets.all(10),
            child: const RequestForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          TextButton(
              onPressed: () {
                FCM().printToken();
              },
              child: const Text(
                "token",
                style: TextStyle(color: Colors.white),
              )),
          IconButton(
              onPressed: () {
                Auth().signOut();
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: Column(
        children: const [
          SizedBox(height: 10,),
          // ElevatedButton(
          //     onPressed: () {},
          //     child: Text("${context.watch<NewUserChecker>().isNew}")),
          Expanded(child: AllRequests()),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              requestBlood();
            },
            elevation: 5.0,
            child: const Icon(
              Icons.add,
              color: Colors.red,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        color: Colors.red,
        height: 50,
        notchMargin: 50,
        elevation: 10,
      ),
    );
  }
}
