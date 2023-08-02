import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../home.dart';
import '../login.dart';
import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart' as firebase;
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    Main(),
  );
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null)
          ? Home(email: FirebaseAuth.instance.currentUser!.email!)
          : Login(),
      builder: EasyLoading.init(),
    );
  }
}
