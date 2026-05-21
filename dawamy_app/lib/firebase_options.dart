import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android: return android;
      case TargetPlatform.iOS: return ios;
      default: return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: 'dawamy-8c61c',
    authDomain: 'dawamy-8c61c.firebaseapp.com',
    storageBucket: 'dawamy-8c61c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: 'dawamy-8c61c',
    storageBucket: 'dawamy-8c61c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: 'dawamy-8c61c',
    storageBucket: 'dawamy-8c61c.appspot.com',
    iosBundleId: 'com.dawamy.app',
  );
}
