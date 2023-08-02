import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'Function/functions.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key});

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
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Product Price',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    selectAndUploadImage();
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("Select Product Image"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber[300],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (downloadUrl.isEmpty) {
                      print("Image URL is empty");
                    } else {
                      add_data(name, price, description, downloadUrl);
                      name.clear();
                      price.clear();
                      description.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add Product"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectAndUploadImage() async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('path == ${file?.path}');
    if (file == null) {
      print("File is empty");
    } else {
      try {
        Reference rootReference = FirebaseStorage.instance.ref();
        Reference imageReference = rootReference.child('images');
        Reference fileReference = imageReference.child(uniqueName);
        await fileReference.putFile(File('${file.path}'));
        downloadUrl = await fileReference.getDownloadURL();
        print("Upload successful");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
