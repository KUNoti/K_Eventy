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
        return macos;
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
    apiKey: 'AIzaSyA3CjKwyqsEpDQJOr0mfucnNyyhi_4WXYs',
    appId: '1:640772781317:web:b51e4b2dfe87bc9370b36c',
    messagingSenderId: '640772781317',
    projectId: 'kunoti',
    authDomain: 'kunoti.firebaseapp.com',
    storageBucket: 'kunoti.appspot.com',
    measurementId: 'G-VRLD5ELTD8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmvuPUnrngv4gsF0_2_3M-nGT5t338TTU',
    appId: '1:640772781317:android:504dd682e3fc946870b36c',
    messagingSenderId: '640772781317',
    projectId: 'kunoti',
    storageBucket: 'kunoti.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6l3LL5FYAZz82Vn5cgCFkLhZHbiECt5A',
    appId: '1:640772781317:ios:37a4b7d9f82cfa8d70b36c',
    messagingSenderId: '640772781317',
    projectId: 'kunoti',
    storageBucket: 'kunoti.appspot.com',
    iosBundleId: 'com.example.kEventy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6l3LL5FYAZz82Vn5cgCFkLhZHbiECt5A',
    appId: '1:640772781317:ios:0d8382c73d67586b70b36c',
    messagingSenderId: '640772781317',
    projectId: 'kunoti',
    storageBucket: 'kunoti.appspot.com',
    iosBundleId: 'com.example.kEventy.RunnerTests',
  );
}