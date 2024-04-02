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
    apiKey: 'AIzaSyD3kIZtHRIylq7q5obTVvh9e7dNMvZzS84',
    appId: '1:688735343902:web:96e8e2dad9cc2b34bbe50f',
    messagingSenderId: '688735343902',
    projectId: 'abbas-16307',
    authDomain: 'abbas-16307.firebaseapp.com',
    storageBucket: 'abbas-16307.appspot.com',
    measurementId: 'G-FGK9Z12076',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5wKtH66BDcGvLg7gmegp0ZFX23bkt-lg',
    appId: '1:688735343902:android:f8d6f75723a1dbcbbbe50f',
    messagingSenderId: '688735343902',
    projectId: 'abbas-16307',
    storageBucket: 'abbas-16307.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOc8r5-5nPsJBghDb-2UuzpJ_YKlh9EL0',
    appId: '1:688735343902:ios:4cc8e8f082ae6c19bbe50f',
    messagingSenderId: '688735343902',
    projectId: 'abbas-16307',
    storageBucket: 'abbas-16307.appspot.com',
    iosBundleId: 'com.example.abbas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOc8r5-5nPsJBghDb-2UuzpJ_YKlh9EL0',
    appId: '1:688735343902:ios:1702eaa91274dcfdbbe50f',
    messagingSenderId: '688735343902',
    projectId: 'abbas-16307',
    storageBucket: 'abbas-16307.appspot.com',
    iosBundleId: 'com.example.abbas.RunnerTests',
  );
}
