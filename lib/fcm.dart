import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCM{
  final FirebaseMessaging _fcm=FirebaseMessaging.instance;
  get fcm=>_fcm;

  getToken(){
    final fcmToken= _fcm.getToken();
    if (kDebugMode) {
      print(fcmToken);
    }

  }
}