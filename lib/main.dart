import 'package:blood_donation/Auth%20pages/WidgetTree.dart';
import 'package:blood_donation/dtbase.dart';
import 'package:blood_donation/providers/newUserCheckProvider.dart';
import 'package:blood_donation/providers/requestCountProviders.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm=FirebaseMessaging.instance;
  @override
  void initState(){
    super.initState();
    _fcm.requestPermission();
    _fcm.getToken().then((token) {
      print("Firebase Token: $token");
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {showLocalNotification(message); });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    showLocalNotification(message);
  }

   showLocalNotification(RemoteMessage message){
    //use flutter local notification package

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (__) => NewUserChecker()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.red,
            appBarTheme: AppBarTheme(

                centerTitle: true,
                titleTextStyle: GoogleFonts.oxanium(fontSize: 30,letterSpacing: 2,fontWeight: FontWeight.w700))),
        home: const WidgetTree(),
      ),
    );
  }
}
