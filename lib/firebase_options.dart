// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBs4glswb3gU6jO0-8GJJWcoQLNAKWFoWM',
    appId: '1:570065127644:web:3a6a0baf9cbf9c24c64c19',
    messagingSenderId: '570065127644',
    projectId: 'saudi-calender',
    authDomain: 'saudi-calender.firebaseapp.com',
    storageBucket: 'saudi-calender.firebasestorage.app',
    measurementId: 'G-3JN4G8X1FR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDG69q0-5chllEidmeUvOQVMcIsenoVlgE',
    appId: '1:570065127644:android:8e0e3e4470c1e145c64c19',
    messagingSenderId: '570065127644',
    projectId: 'saudi-calender',
    storageBucket: 'saudi-calender.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKmCaS5xti_6QTF9CaRLKAQhMNEY0VZIM',
    appId: '1:570065127644:ios:b8d0a4c608e39810c64c19',
    messagingSenderId: '570065127644',
    projectId: 'saudi-calender',
    storageBucket: 'saudi-calender.firebasestorage.app',
    iosBundleId: 'com.example.saudiCalenderTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBKmCaS5xti_6QTF9CaRLKAQhMNEY0VZIM',
    appId: '1:570065127644:ios:b8d0a4c608e39810c64c19',
    messagingSenderId: '570065127644',
    projectId: 'saudi-calender',
    storageBucket: 'saudi-calender.firebasestorage.app',
    iosBundleId: 'com.example.saudiCalenderTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBs4glswb3gU6jO0-8GJJWcoQLNAKWFoWM',
    appId: '1:570065127644:web:dfeb6c3655dc5096c64c19',
    messagingSenderId: '570065127644',
    projectId: 'saudi-calender',
    authDomain: 'saudi-calender.firebaseapp.com',
    storageBucket: 'saudi-calender.firebasestorage.app',
    measurementId: 'G-WRPRY5R059',
  );
}
