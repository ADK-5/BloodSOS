import 'package:blood_donation/Auth%20pages/WidgetTree.dart';
import 'package:blood_donation/dtbase.dart';
import 'package:blood_donation/providers/newUserCheckProvider.dart';
import 'package:blood_donation/providers/requestCountProviders.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState(){
  //   super.initState();
  //   DB().getRequests();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Counter()),
        ChangeNotifierProvider(create: (__)=>NewUserChecker()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: const WidgetTree(),
      ),
    );
  }
}