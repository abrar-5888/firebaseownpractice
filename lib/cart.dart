import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:js/js.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebaseownpractice/Function/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var downloadUrl = '';
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String Iurl = '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Product"),
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
                onPressed: () async {
                  // ImagePicker imagePicker = ImagePicker();
                  // XFile? file =
                  //     await imagePicker.pickImage(source: ImageSource.camera);
                  // print('${file?.path}');
                  // if (file == null) {
                  //   print('No imae selected');
                  // } else {
                  //   String uniquefilename =
                  //       DateTime.now().millisecondsSinceEpoch.toString();

                  //   Reference reference = FirebaseStorage.instance.ref();
                  //   Reference dir_refer = reference.child('Images');
                  //   Reference iuploaded = dir_refer.child(uniquefilename);
                  //   try {
                  //     await iuploaded.putFile(File(file.path));
                  //     Iurl = await iuploaded.getDownloadURL();
                  //   } catch (error) {
                  //     print(
                  //         // 'error'
                  //         error.toString());
                  //   }
                  // }

                  // PlatformFile? _imageFile;
                  // try {
                  //   // Pick an image file using file_picker package
                  //   FilePickerResult? result =
                  //       await FilePicker.platform.pickFiles(
                  //     type: FileType.image,
                  //   );

                  //   // If user cancels the picker, do nothing
                  //   if (result == null) return;

                  //   // If user picks an image, update the state with the new image file
                  //   setState(() {
                  //     _imageFile = result.files.first;
                  //   });
                  // } catch (e) {
                  //   // If there is an error, show a snackbar with the error message
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(e.toString()),
                  //     ),
                  //   );
                  // }
                  selectAndUploadImage();
                },
                icon: Icon(Icons.camera_alt)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
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
          downloadUrl = await snapshot.ref.getDownloadURL();
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
}
