import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCfZOM_t9wB6ltsobk_tnOLRBSgochqaj4',
    appId: '1:420969451163:web:d66f3a5ba73122f734003e',
    messagingSenderId: '420969451163',
    projectId: 'bakal-titans',
    authDomain: 'bakal-titans.firebaseapp.com',
    storageBucket: 'bakal-titans.firebasestorage.app',
    measurementId: 'G-J9CFVN4DHG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAAa0kPv270jKdK1DsOcweeySwa12npLk',
    appId: '1:420969451163:android:78f0583677dc0b9334003e',
    messagingSenderId: '420969451163',
    projectId: 'bakal-titans',
    storageBucket: 'bakal-titans.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrBauQGyvEToSbwVtoDWTz1UY4Snqi2DE',
    appId: '1:420969451163:ios:b3168e2254f5ee5d34003e',
    messagingSenderId: '420969451163',
    projectId: 'bakal-titans',
    storageBucket: 'bakal-titans.firebasestorage.app',
    iosClientId: 'your-ios-client-id',
    iosBundleId: 'com.example.myProject',
  );
}