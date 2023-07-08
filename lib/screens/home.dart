import 'package:blood_donation/auth.dart';
import 'package:blood_donation/commons/fieldStyle.dart';
import 'package:blood_donation/screens/requestPage.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:blood_donation/dtbase.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void requestBlood(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
          padding: EdgeInsets.all(10),
        child: RequestForm(),

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
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FittedBox(
          child: FloatingActionButton(onPressed: (){
            requestBlood();
          },elevation: 5.0,child: const Icon(Icons.add,color: Colors.red,),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
