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
    apiKey: 'AIzaSyBR2a3k0e8D-PqtWrdjVySVDaGWEJlIKO8',
    appId: '1:94343254489:web:baaf83ca26dd0bbb8309c8',
    messagingSenderId: '94343254489',
    projectId: 'weatherapp-de1eb',
    authDomain: 'weatherapp-de1eb.firebaseapp.com',
    storageBucket: 'weatherapp-de1eb.appspot.com',
    measurementId: 'G-13P02L2D22',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApkDuRzon1G8BzLwBewzwXx8_P8_Z5K0k',
    appId: '1:94343254489:android:8ae1f92baafa7d0f8309c8',
    messagingSenderId: '94343254489',
    projectId: 'weatherapp-de1eb',
    storageBucket: 'weatherapp-de1eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyo5e8Erv4x59ZIJDjTZ-6mnWeMMevwJI',
    appId: '1:94343254489:ios:aeb4dea85cd11b988309c8',
    messagingSenderId: '94343254489',
    projectId: 'weatherapp-de1eb',
    storageBucket: 'weatherapp-de1eb.appspot.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyo5e8Erv4x59ZIJDjTZ-6mnWeMMevwJI',
    appId: '1:94343254489:ios:aeb4dea85cd11b988309c8',
    messagingSenderId: '94343254489',
    projectId: 'weatherapp-de1eb',
    storageBucket: 'weatherapp-de1eb.appspot.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBR2a3k0e8D-PqtWrdjVySVDaGWEJlIKO8',
    appId: '1:94343254489:web:097b98be4a23bdd88309c8',
    messagingSenderId: '94343254489',
    projectId: 'weatherapp-de1eb',
    authDomain: 'weatherapp-de1eb.firebaseapp.com',
    storageBucket: 'weatherapp-de1eb.appspot.com',
    measurementId: 'G-NEVZ14Y2HT',
  );
}
