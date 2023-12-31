// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC7p5qHm1Oq6KponVDo3mff4ELbl4eUsHs',
    appId: '1:143292030531:web:ff12470d1ff8c406b67ef6',
    messagingSenderId: '143292030531',
    projectId: 'bloodsos-a5c2f',
    authDomain: 'bloodsos-a5c2f.firebaseapp.com',
    storageBucket: 'bloodsos-a5c2f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeBI17YEiI6NEwND_1ZNHp7YlUBiR3SBo',
    appId: '1:143292030531:android:fc2833b75aa3d6cfb67ef6',
    messagingSenderId: '143292030531',
    projectId: 'bloodsos-a5c2f',
    storageBucket: 'bloodsos-a5c2f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-4mVIO8Nv3UTJx8SC7gpIKDbcxGpopU0',
    appId: '1:143292030531:ios:202c5f57fcd92f8ab67ef6',
    messagingSenderId: '143292030531',
    projectId: 'bloodsos-a5c2f',
    storageBucket: 'bloodsos-a5c2f.appspot.com',
    iosClientId: '143292030531-ueagva424icfugn9dqt0pdkovq215oj7.apps.googleusercontent.com',
    iosBundleId: 'com.example.bloodDonation',
  );
}
