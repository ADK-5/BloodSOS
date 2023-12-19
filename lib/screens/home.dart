import 'package:blood_donation/auth.dart';
import 'package:blood_donation/fcm.dart';
import 'package:blood_donation/screens/all_requests.dart';
import 'package:blood_donation/screens/requestPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final fcmToken;
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
          IconButton(
              onPressed: () {
                Auth().signOut();
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 30),
                child: Icon(Icons.person,size: 35),
              ))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () async {
                var Token=await FirebaseMessaging.instance.getToken();
                setState(() {
                  fcmToken=Token;
                  print(fcmToken);
                });
              },
              child: const Text("kuchh bhi")),
          const Expanded(child: AllRequests()),
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
              color: Colors.white,
              size: 40,
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
