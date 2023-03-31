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
    apiKey: 'AIzaSyCM8KWbyqOz9UvliBHIA_RgTTJB8oTM46I',
    appId: '1:36227737701:web:96235959de1af820413e8c',
    messagingSenderId: '36227737701',
    projectId: 'todoklikkers-74033',
    authDomain: 'todoklikkers-74033.firebaseapp.com',
    storageBucket: 'todoklikkers-74033.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCye5F4T6r1O_DzQtnDaYcPJ8cPpxpiiiI',
    appId: '1:36227737701:android:7562a0fb9a05851d413e8c',
    messagingSenderId: '36227737701',
    projectId: 'todoklikkers-74033',
    storageBucket: 'todoklikkers-74033.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaDEjSwNrvszWIkTmAPeW6wiWpSjKCLuU',
    appId: '1:36227737701:ios:1c0d2041903dd514413e8c',
    messagingSenderId: '36227737701',
    projectId: 'todoklikkers-74033',
    storageBucket: 'todoklikkers-74033.appspot.com',
    iosClientId: '36227737701-2sl2k2davi8d38l7i1rauq8j29hbqq5l.apps.googleusercontent.com',
    iosBundleId: 'com.example.ehisaab2',
  );
}
