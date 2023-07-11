import 'package:blood_donation/Auth%20pages/WidgetTree.dart';
import 'package:blood_donation/dtbase.dart';
import 'package:blood_donation/providers/requstCountProviders.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Counter()),
        ChangeNotifierProvider(create: (b)=>Database()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: const WidgetTree(),
      ),
    );
  }
}