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
    apiKey: 'AIzaSyDKJeN3FFN677C930C8TUrs4_smGPX9PYY',
    appId: '1:900729736011:web:114e38fe1a8587a8b576ce',
    messagingSenderId: '900729736011',
    projectId: 'ninety-camera',
    authDomain: 'ninety-camera.firebaseapp.com',
    storageBucket: 'ninety-camera.appspot.com',
    measurementId: 'G-N42TWY7Q9C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeGB_nckFz5Jn3cWlsUvV_bWp17eQWF-Q',
    appId: '1:900729736011:android:0b277df060105cf0b576ce',
    messagingSenderId: '900729736011',
    projectId: 'ninety-camera',
    storageBucket: 'ninety-camera.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsTJGS-__xtw7YdX1-BCb6_74PzZ38FPo',
    appId: '1:900729736011:ios:77ba51970df01b28b576ce',
    messagingSenderId: '900729736011',
    projectId: 'ninety-camera',
    storageBucket: 'ninety-camera.appspot.com',
    iosClientId: '900729736011-19luusfenlb2n0pcaru53eot6t8qo8ul.apps.googleusercontent.com',
    iosBundleId: 'com.example.ninety',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsTJGS-__xtw7YdX1-BCb6_74PzZ38FPo',
    appId: '1:900729736011:ios:77ba51970df01b28b576ce',
    messagingSenderId: '900729736011',
    projectId: 'ninety-camera',
    storageBucket: 'ninety-camera.appspot.com',
    iosClientId: '900729736011-19luusfenlb2n0pcaru53eot6t8qo8ul.apps.googleusercontent.com',
    iosBundleId: 'com.example.ninety',
  );
}
