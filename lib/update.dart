import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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
  String uurl = "";

  @override
  void initState() {
    super.initState();
    name.text = widget.nameee;
    description.text = widget.descriptionnn;
    price.text = widget.priceee;
    uurl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.id;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orange],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'New Product Name',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    labelText: 'New Product Description',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'New Product Price',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    selectAndUpdateImage();
                    print(downloadUrl);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Select and Update Image'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
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
                    primary: Colors.orangeAccent,
                    shape: BeveledRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> selectAndUpdateImage() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );
  //   if (result != null) {
  //     final file = result.files.single;

  //     if (file.bytes != null) {
  //       final blob = blobFromUint8List(file.bytes!);
  //       print('BLOB is NOT EMPTY');

  //       final storageRef = firebase_storage.FirebaseStorage.instance
  //           .ref()
  //           .child('images/${DateTime.now().millisecondsSinceEpoch}');

  //       final uploadTask = storageRef.putData(blob);
  //       print("File = =  ${file}");
  //       print('upload complete == ${uploadTask}');
  //       uploadTask.then((snapshot) async {
  //         if (snapshot.state == firebase_storage.TaskState.success) {
  //           downloadUrl = await snapshot.ref.getDownloadURL();
  //           print('Image updated successfully. Download URL: $downloadUrl');
  //         } else {
  //           print('Image update failed.');
  //         }
  //       }).catchError((error) {
  //         print('Error during image update: $error');
  //       });
  //     } else {
  //       print('No image selected.');
  //     }
  //   } else {
  //     print('result == empty     ${result}');
  //   }
  // }

  // Uint8List blobFromUint8List(Uint8List uint8List) {
  //   return uint8List;
  // }

  void selectAndUpdateImage() async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    ImagePicker imagePicker = ImagePicker();

    // Show a dialog to let the user choose between gallery and camera
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              child: Text('Gallery'),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
            TextButton(
              child: Text('Camera'),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        );
      },
    );

    if (source == null) {
      print("No image source selected");
      return;
    }

    XFile? file = await imagePicker.pickImage(source: source);

    print('path == ${file?.path}');

    if (file == null) {
      print("File is empty");
    } else {
      try {
        Reference referenceimagetoupdate =
            FirebaseStorage.instance.refFromURL(uurl);
        await referenceimagetoupdate.putFile(File('${file.path}'));
        downloadUrl = await referenceimagetoupdate.getDownloadURL();
        print("Upload successful");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
