// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBbgteFAxmymToIr_MzHUrrc1B9JPZpq6Y',
    appId: '1:103982216696:web:8b2955dce0f2d75a31520d',
    messagingSenderId: '103982216696',
    projectId: 'xo-flutter',
    authDomain: 'xo-flutter.firebaseapp.com',
    storageBucket: 'xo-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2UXVe_VXfrX50pQX8LjLWHJwWUpe6HVA',
    appId: '1:103982216696:android:a213f771904cb2cf31520d',
    messagingSenderId: '103982216696',
    projectId: 'xo-flutter',
    storageBucket: 'xo-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiqQqZgR8RbahQVd3RQb3Grb-lKRtZrGo',
    appId: '1:103982216696:ios:92320d642c6ac1d931520d',
    messagingSenderId: '103982216696',
    projectId: 'xo-flutter',
    storageBucket: 'xo-flutter.appspot.com',
    iosClientId: '103982216696-3vmsti5nghcpsfrvgh09ltn1fh523rrg.apps.googleusercontent.com',
    iosBundleId: 'com.x-o',
  );
}
