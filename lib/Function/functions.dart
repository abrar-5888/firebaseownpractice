import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../login.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// login page functions !

void signin(TextEditingController emailcontroller,
    TextEditingController passcontroller, BuildContext context) async {
  String email = emailcontroller.text.trim();
  String pass = passcontroller.text.trim();
  if (email == "" || pass == "") {
    print("Plz fill all fields ! ");
  } else {
    try {
      EasyLoading.show(status: "Loading");
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      EasyLoading.dismiss();
      if (userCredential != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
      }
    } on FirebaseAuthException catch (ex) {
      EasyLoading.showError(ex.code.toString());
    }
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
      EasyLoading.dismiss();
      if (userCredential != null) {
        Navigator.pop(context);
        print("user created");
      }
    } on FirebaseAuthException catch (ex) {
      print(ex.code.toString());
    }
  }
}

// SIGN OUT  function

void signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
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

// Upload Image

Future<void> selectAndUploadImage() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (result != null) {
    final file = result.files.single;
    final blob = blobFromUint8List(file.bytes!);

    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');

    final uploadTask = storageRef.putData(blob);
    uploadTask.then((snapshot) async {
      if (snapshot.state == firebase_storage.TaskState.success) {
        final downloadUrl = await snapshot.ref.getDownloadURL();

        print('Image uploaded successfully. Download URL: $downloadUrl');
      } else {
        print('Image upload failed.');
      }
    }).catchError((error) {
      print('Error during image upload: $error');
    });
  } else {
    print('No image selected.');
  }
}

Uint8List blobFromUint8List(Uint8List uint8List) {
  return uint8List;
}
