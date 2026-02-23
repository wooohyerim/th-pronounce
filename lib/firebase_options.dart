// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // 🔥 Android 설정
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBKs-4DTGLK_3cNVZCmxp95Ie8BycFYsGo",
    appId: '1:1062578056837:android:de55ba5ba5b59c3de5c3ec',
    projectId: 'th-pronounce',
    storageBucket: 'th-pronounce.firebasestorage.app',
    messagingSenderId: "1062578056837",
  );

  // 🔥 iOS 설정
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuKtTGt48sm5__zBaoEuqTCFc-fnHMaGg',
    appId: '1:1062578056837:ios:28963de81741ac2ae5c3ec',
    projectId: 'th-pronounce',
    storageBucket: 'th-pronounce.firebasestorage.app',
    iosBundleId: 'com.example.thPronounceApp',
    messagingSenderId: "1062578056837",
  );
}
