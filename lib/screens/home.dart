import 'package:blood_donation/auth.dart';
import 'package:blood_donation/fcm.dart';
import 'package:blood_donation/screens/requestPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dtbase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


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
  void initState() {
    context.read<Database>().getRequests();
    FCM().getToken();
    FirebaseMessaging.instance.getToken().then((value) {
      if (kDebugMode) {
        print('token: $value');
      }
    },
    onError: (error){
      print(error);
    },
    );
    super.initState();
  }
  List displayRequests=[];



  @override
  Widget build(BuildContext context) {
    displayRequests=context.watch<Database>().allRequests;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 700,
            child: ListView.builder(
                itemCount: displayRequests.length,
                itemBuilder: (context,index){
              return Container(
                decoration: BoxDecoration(color: Colors.greenAccent,border: Border.all(color: Colors.black,width: 1),),
                child: ListTile(
                  title: Text("${displayRequests[index]['City']},${displayRequests[index]['State']}"),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${displayRequests[index]['Blood Group']}"),
                      Text("${displayRequests[index]['Units']} units")
                    ],
                  ),
                  subtitle: const Text("data"),
                ),
              );
            }),
          ),
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
      bottomNavigationBar: const BottomAppBar(color: Colors.red,height: 50,notchMargin: 50,elevation: 10,),
    );
  }
}
