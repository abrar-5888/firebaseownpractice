import 'package:firebaseownpractice/email_verification.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../login.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String? gogemail;
// login page functions !

void signin(
  TextEditingController emailcontroller,
  TextEditingController passcontroller,
  BuildContext context,
) async {
  String email = emailcontroller.text.trim();
  String pass = passcontroller.text.trim();

  if (email == "" || pass == "") {
    print("Please fill all fields!");
    return;
  }

  try {
    EasyLoading.show(status: "Loading");
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);

    User? user = userCredential.user;
    bool isverify = user?.emailVerified ?? false;

    if (isverify) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Success");

      await saveEmailToFirestore(email);

      String userid = FirebaseAuth.instance.currentUser!.uid;
      print(userid);

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(email: email)),
      );
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger(
        child: Text("Please Verify your Email"),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Email_verify()),
      );
    }
  } on FirebaseAuthException catch (ex) {
    EasyLoading.dismiss();
    EasyLoading.showError(ex.code.toString());
  }
}

// save email to firestore

Future<void> saveEmailToFirestore(String? email) async {
  try {
    await FirebaseFirestore.instance.collection('emails').doc(email).set({
      'email': email,
      // 'google-email': gogemail,
      'isupdateAllowed': isupdateallowu,
      'isdeleteAllowed': isdeleteallowu
    });
  } catch (e) {
    print("Error saving email to Firestore: $e");
  }
}

// signup functions

void Create_Account(
    TextEditingController emailcontroller,
    TextEditingController passcontroller,
    TextEditingController cpasscontroller,
    BuildContext context) async {
  String email = emailcontroller.text.trim();
  String pass = passcontroller.text.trim();
  String cpass = cpasscontroller.text.trim();

  if (email == "" || pass == "" || cpass == "") {
    print("Please fill all the Fields !");
  } else if (pass != cpass) {
    print("Passwords do not match !");
  } else {
    try {
      EasyLoading.show(status: "Loading");
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      EasyLoading.show(status: "Verify Your Email");
      if (userCredential != null) {
        await saveEmailToFirestore(email);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Email_verify(),
            ));
        print("user created");
      }
    } catch (ex) {
      print(ex.toString());
    }
  }
}

//  SIGN IN WITH GOOGLE

void signingoogle(BuildContext context) async {
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a Google account")),
      );
    }

    GoogleSignInAuthentication? googleSignInAuth =
        await googleUser?.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuth?.accessToken,
      idToken: googleSignInAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    gogemail = userCredential.user?.email;
    String? name = userCredential.user?.displayName;
    if (userCredential != null) {
      await saveEmailToFirestore(gogemail);
      bool isverify = userCredential.user?.emailVerified ?? false;

      if (gogemail != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => Home(email: gogemail))),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logged in as $name")),
        );
      }
    }
  } catch (e) {
    print("Sign-in canceled: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Sign-in canceled")),
    );
  }
}

// SIGN OUT  function

void signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  Navigator.popUntil(context, (route) => route.isFirst);
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ));
}

// cart Function

void add_data(
    TextEditingController namecontroller,
    TextEditingController pricecontroller,
    TextEditingController descriptioncontroller,
    String downloadUrl) async {
  String name = namecontroller.text.toString();
  String price = pricecontroller.text.toString();
  String description = descriptioncontroller.text.toString();
  String url = downloadUrl;

  CollectionReference user = FirebaseFirestore.instance.collection("users");
  if (name == "" || price == "" || description == "" || url == "") {
    print("Plz fill all fields");
  } else {
    try {
      EasyLoading.show(status: 'Adding user...');
      await user.add({
        'name': name,
        'price': price,
        'description': description,
        'image': url
      });
      EasyLoading.dismiss();
      print("User added successfully");
    } catch (error) {
      EasyLoading.dismiss();
      print("Failed to add user: $error");
    }
  }
}

// Update data function

void updateData(
    TextEditingController nameController,
    TextEditingController priceController,
    TextEditingController descriptionController,
    String documentId,
    String downloadUrl) async {
  String name = nameController.text.trim();
  String price = priceController.text.trim();
  String description = descriptionController.text.trim();
  var documentID = documentId;
  var url = downloadUrl;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  if (name.isEmpty ||
      price.isEmpty ||
      description.isEmpty ||
      downloadUrl.isEmpty) {
    print("Please fill in all fields");
  }

  try {
    EasyLoading.show(status: 'Updating ...');
    final docSnapshot = await users.doc(documentID).get();
    if (!docSnapshot.exists) {
      print("Document does not exist");
    }
    await users.doc(documentID).set({
      'name': name,
      'price': price,
      'description': description,
      'image': url
    }, SetOptions(merge: true));

    EasyLoading.dismiss();
    print("Updated successfully");
  } catch (error) {
    EasyLoading.dismiss();
    print("Failed to update data: $error");
  }
}

//test
bool isupdateallowu = true;
bool isdeleteallowu = true;
void allowupdate(bool allowbtn) {
  isupdateallowu = allowbtn;
}

bool to() {
  print(isupdateallowu);

  return isupdateallowu;
}

void allowdelete(bool allowbtn) {
  isdeleteallowu = allowbtn;
}

bool todelete() {
  print(isdeleteallowu);
  return isdeleteallowu;
}

// allow delete from firebase
