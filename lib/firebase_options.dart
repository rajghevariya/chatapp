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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDP8d402Zg_Cyw_1GdPAjvTF1C4QsH4I_A',
    appId: '1:809676147458:android:c61816112d975dc16f501b',
    messagingSenderId: '809676147458',
    projectId: 'i-chat-app-92efd',
    storageBucket: 'i-chat-app-92efd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCYZoZ5DvuitZJ7qK5iWM3ARHBDoFFriY',
    appId: '1:288842837392:ios:f39c8dc31525a6687a5715',
    messagingSenderId: '288842837392',
    projectId: 'we-chat-75f13',
    storageBucket: 'we-chat-75f13.appspot.com',
    androidClientId: '288842837392-gvt1l790g0t1fmnurc5pmko3oss8b1tq.apps.googleusercontent.com',
    iosClientId: '288842837392-sgib97u6439i4jte3bo19u00fh663euu.apps.googleusercontent.com',
    iosBundleId: 'com.harshRajpurohit.weChat',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBW-1MjB067GUwQHPnYmWkr_4iMz13UgRs',
    appId: '1:288842837392:web:6ae5bafc6d7d4f407a5715',
    messagingSenderId: '288842837392',
    projectId: 'we-chat-75f13',
    authDomain: 'we-chat-75f13.firebaseapp.com',
    storageBucket: 'we-chat-75f13.appspot.com',
  );

}