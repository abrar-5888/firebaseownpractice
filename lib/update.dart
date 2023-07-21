import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'Function/functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Update extends StatefulWidget {
  final String nameee;
  final String descriptionnn;
  final String id;
  final String priceee;
  final url;

  Update(
    this.nameee,
    this.descriptionnn,
    this.priceee,
    this.id,
    this.url,
  );

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  var downloadUrl = '';
  var users = FirebaseFirestore.instance.collection("users").snapshots();

  final document = FirebaseFirestore.instance.collection('users').snapshots();

  TextEditingController name = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text = widget.nameee;
    description.text = widget.descriptionnn;
    String id = widget.id;

    price.text = widget.priceee;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'New Product Name '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: description,
              decoration: InputDecoration(hintText: 'New Product Description '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: price,
              decoration: InputDecoration(hintText: 'New Product Price '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  selectAndUpdateImage();
                },
                icon: Icon(Icons.camera_alt)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                updateData(name, price, description, id, downloadUrl);
                name.clear();
                price.clear();
                description.clear();
                Navigator.pop(context);
              },
              child: Text(
                "Update Product",
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

  Future<void> selectAndUpdateImage() async {
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
          downloadUrl = await snapshot.ref.getDownloadURL();
          print('Image updated successfully. Download URL: $downloadUrl');
        } else {
          print('Image updated failed.');
        }
      }).catchError((error) {
        print('Error during image upadte: $error');
      });
    } else {
      print('No image selected.');
    }
  }

  Uint8List blobFromUint8List(Uint8List uint8List) {
    return uint8List;
  }
}
