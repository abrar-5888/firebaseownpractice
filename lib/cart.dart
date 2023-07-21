// import 'dart:js_interop';
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'Function/functions.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  var downloadUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Product Name '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: description,
              decoration: InputDecoration(hintText: 'Product Description '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: price,
              decoration: InputDecoration(hintText: 'Product Price '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  selectanduploadimage();
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (downloadUrl.isEmpty) {
                  print("Image url is empty");
                }
                add_data(name, price, description, downloadUrl);
                name.clear();
                price.clear();
                description.clear();
                Navigator.pop(context);
              },
              child: Text(
                "Add Product",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: BeveledRectangleBorder(
                    side: BorderSide(
                  color: Colors.black,
                  width: 1,
                )),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void selectanduploadimage() async {
    String unique_name = DateTime.now().millisecondsSinceEpoch.toString();
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('path == ${file?.path}');
    if (file == null) {
      print("File is empty");
    } else {
      try {
        Reference referenceroot = FirebaseStorage.instance.ref();
        Reference reference = referenceroot.child('images');
        Reference refer = reference.child(unique_name);
        await refer.putFile(File('${file.path}'));
        downloadUrl = await refer.getDownloadURL();
        print("Upload sucessfull");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
