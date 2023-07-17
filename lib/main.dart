import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseownpractice/firebase_options.dart';
import 'package:firebaseownpractice/home.dart';
import 'package:firebaseownpractice/login.dart';
import 'package:flutter/material.dart';

import 'package:firebase/firebase.dart' as firebase;
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    Main(),
  );
  // configLoading();
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null) ? Home() : Login(),
      builder: EasyLoading.init(),
    );
  }
}
