import 'package:cloud_firestore/cloud_firestore.dart';
import './home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Function/functions.dart';

class Users extends StatefulWidget {
  final String email;

  Users({
    required this.email,
  });

  @override
  State<Users> createState() => UsersState();
}

class UsersState extends State<Users> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var emails = FirebaseFirestore.instance.collection('emails').snapshots();

  bool isupdateallowu = true;
  bool isdeleteallowu = true;

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    return Scaffold(
      appBar:
          AppBar(title: Text("Admin Panel"), backgroundColor: Colors.orange),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Admin:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                email,
                style: TextStyle(fontSize: 16),
              ),
              Divider(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: emails,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final document = snapshot.data!.docs[index];
                          final data = document.data() as Map<String, dynamic>?;
                          var id = document.id;
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Text(
                                (data as Map<String, dynamic>)['email'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Text(
                                    "Update Permission:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isupdateallowu = true;
                                            FirebaseFirestore.instance
                                                .collection('emails')
                                                .doc(id)
                                                .update({
                                              'isupdateAllowed': isupdateallowu
                                            }).then((_) {
                                              setState(() {
                                                FirebaseFirestore.instance
                                                    .collection('emails')
                                                    .doc(id)
                                                    .update({
                                                  'isupdateAllowed':
                                                      isupdateallowu
                                                });
                                                print(isupdateallowu);
                                                allowupdate(isupdateallowu);
                                              });
                                            });
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Text("Allow"),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isupdateallowu = false;
                                            FirebaseFirestore.instance
                                                .collection('emails')
                                                .doc(id)
                                                .update({
                                              'isupdateAllowed': isupdateallowu
                                            }).then((_) {
                                              setState(() {
                                                FirebaseFirestore.instance
                                                    .collection('emails')
                                                    .doc(id)
                                                    .update({
                                                  'isupdateAllowed':
                                                      isupdateallowu
                                                });
                                                print(isupdateallowu);
                                                allowupdate(isupdateallowu);
                                              });
                                            });
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Text("Deny"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Delete Permission:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            FirebaseFirestore.instance
                                                .collection('emails')
                                                .doc(id)
                                                .update({
                                              'isdeleteAllowed': true
                                            }).then((_) {
                                              setState(() {
                                                FirebaseFirestore.instance
                                                    .collection('emails')
                                                    .doc(id)
                                                    .update({
                                                  'isdeleteAllowed': true
                                                });
                                                isdeleteallowu = true;
                                                print(isdeleteallowu);
                                                allowdelete(isdeleteallowu);
                                              });
                                            });
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Text("Allow"),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            FirebaseFirestore.instance
                                                .collection('emails')
                                                .doc(id)
                                                .update({
                                              'isdeleteAllowed': false
                                            }).then((_) {
                                              setState(() {
                                                FirebaseFirestore.instance
                                                    .collection('emails')
                                                    .doc(id)
                                                    .update({
                                                  'isdeleteAllowed': false
                                                });
                                                isdeleteallowu = false;
                                                print(isdeleteallowu);
                                                allowdelete(isdeleteallowu);
                                              });
                                            });
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Text("Deny"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
