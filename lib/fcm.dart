import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCM{
  final FirebaseMessaging _fcm=FirebaseMessaging.instance;
  // final fcmToken= _fcm.getToken();
  void printToken(){
    final fcmToken=_fcm.getToken();
    if (kDebugMode) {
      print(
      fcmToken
    );
    }
  }
}

