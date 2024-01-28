// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyASbIjRFNnkWSRp9NG4d6N9JvtMmhkaslk',
    appId: '1:593058348208:android:816c87c94b5d63d2588f75',
    messagingSenderId: '593058348208',
    projectId: 'miro-template-app',
    storageBucket: 'miro-template-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4WqMUtv1ehozu6ewDus1cuhRlLpgs2c0',
    appId: '1:593058348208:ios:19fbb30500e385cb588f75',
    messagingSenderId: '593058348208',
    projectId: 'miro-template-app',
    storageBucket: 'miro-template-app.appspot.com',
    androidClientId: '593058348208-ndjjah8js3iavlus8jl4hhp1rh83ou4v.apps.googleusercontent.com',
    iosClientId: '593058348208-85bcfq2bmmm1pnf7tmt83tafqgp57biu.apps.googleusercontent.com',
    iosBundleId: 'com.example.template',
  );
}
