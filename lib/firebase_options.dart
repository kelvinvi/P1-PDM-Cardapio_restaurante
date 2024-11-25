import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBIN613R7mrE-Elai06TNL-_qWJPlE7hzs',
    appId: '1:831638446592:web:88e1043469fcdbfeb36ee5',
    messagingSenderId: '831638446592',
    projectId: 'cardapio-restaurante-e57df',
    authDomain: 'cardapio-restaurante-e57df.firebaseapp.com',
    storageBucket: 'cardapio-restaurante-e57df.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjIHjH_iXx7QjiPprCAmq9bpa4EwWjnE4',
    appId: '1:831638446592:android:8828daf453c4567fb36ee5',
    messagingSenderId: '831638446592',
    projectId: 'cardapio-restaurante-e57df',
    storageBucket: 'cardapio-restaurante-e57df.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyHBUPcjMOSY47fynOaWGmwv5751Q68oA',
    appId: '1:831638446592:ios:5c92ce485ff23ca6b36ee5',
    messagingSenderId: '831638446592',
    projectId: 'cardapio-restaurante-e57df',
    storageBucket: 'cardapio-restaurante-e57df.firebasestorage.app',
    iosBundleId: 'com.example.cardapioRestaurante',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyHBUPcjMOSY47fynOaWGmwv5751Q68oA',
    appId: '1:831638446592:ios:5c92ce485ff23ca6b36ee5',
    messagingSenderId: '831638446592',
    projectId: 'cardapio-restaurante-e57df',
    storageBucket: 'cardapio-restaurante-e57df.firebasestorage.app',
    iosBundleId: 'com.example.cardapioRestaurante',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBIN613R7mrE-Elai06TNL-_qWJPlE7hzs',
    appId: '1:831638446592:web:6cf202c3c314935eb36ee5',
    messagingSenderId: '831638446592',
    projectId: 'cardapio-restaurante-e57df',
    authDomain: 'cardapio-restaurante-e57df.firebaseapp.com',
    storageBucket: 'cardapio-restaurante-e57df.firebasestorage.app',
  );
}
