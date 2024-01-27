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
    apiKey: 'AIzaSyAPrXI_4SHiJtkIdU8NLyhEbW7uqNr0tzQ',
    appId: '1:589481217870:web:ad058ccbac10f5f5c1581f',
    messagingSenderId: '589481217870',
    projectId: 'catatan-harian-2024',
    authDomain: 'catatan-harian-2024.firebaseapp.com',
    storageBucket: 'catatan-harian-2024.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCA0OwYkS629vfC1PhJAwui0ECw2pKwhLU',
    appId: '1:589481217870:android:59e46869950a7c28c1581f',
    messagingSenderId: '589481217870',
    projectId: 'catatan-harian-2024',
    storageBucket: 'catatan-harian-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZbtYNy_lPABQXPQ_ARxfJFYAEB9AfgEU',
    appId: '1:589481217870:ios:8b6448eac5f84084c1581f',
    messagingSenderId: '589481217870',
    projectId: 'catatan-harian-2024',
    storageBucket: 'catatan-harian-2024.appspot.com',
    iosBundleId: 'com.example.uasMaghfira',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZbtYNy_lPABQXPQ_ARxfJFYAEB9AfgEU',
    appId: '1:589481217870:ios:bd425d33ff445309c1581f',
    messagingSenderId: '589481217870',
    projectId: 'catatan-harian-2024',
    storageBucket: 'catatan-harian-2024.appspot.com',
    iosBundleId: 'com.example.uasMaghfira.RunnerTests',
  );
}