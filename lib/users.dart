// import 'package:firebase/firebase.dart';
// import 'package:firebaseownpractice/Function/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseownpractice/home.dart';
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
      appBar: AppBar(title: Text("Admin Panel")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: Column(
          children: [
            Text(
              "Current Admin = ${email}",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Container(
              color: Colors.transparent,
              width: double.infinity,
              height: 6,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: emails,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      final data = document.data() as Map<String, dynamic>?;
                      var id = document.id;
                      return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: ListTile(
                              title: Row(
                            children: [
                              Container(
                                width: 89,
                                child: Text(
                                  (data as Map<String, dynamic>)['email'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('emails')
                                                        .doc(id)
                                                        .update({
                                                      'isupdateAllowed': true
                                                    }).then((_) => {
                                                              setState(() {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'emails')
                                                                    .doc(id)
                                                                    .update({
                                                                  'isupdateAllowed':
                                                                      true
                                                                });
                                                                isupdateallowu =
                                                                    true;
                                                                print(
                                                                    isupdateallowu);
                                                                // Home().check("Allow is pressed");
                                                                allowupdate(
                                                                    isupdateallowu);
                                                                to();

                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Home(email: email),
                                                                        ));
                                                              })
                                                            });
                                                  });
                                                },
                                                child: Text(
                                                  "Allow",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlue[300]),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('emails')
                                                        .doc(id)
                                                        .update({
                                                      'isupdateAllowed': false
                                                    }).then((_) => {
                                                              setState(() {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'emails')
                                                                    .doc(id)
                                                                    .update({
                                                                  'isupdateAllowed':
                                                                      false
                                                                });
                                                                isupdateallowu =
                                                                    false;
                                                                print(
                                                                    isupdateallowu);
                                                                // Home().check("Allow is pressed");
                                                                allowupdate(
                                                                    isupdateallowu);
                                                                to();
                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Home(email: email),
                                                                        ));
                                                              })
                                                            });
                                                  });
                                                },
                                                child: Text(
                                                  "Deny",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('emails')
                                                        .doc(id)
                                                        .update({
                                                      'isdeleteAllowed': true
                                                    }).then((_) => {
                                                              setState(() {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'emails')
                                                                    .doc(id)
                                                                    .update({
                                                                  'isdeleteAllowed':
                                                                      true
                                                                });
                                                                isdeleteallowu =
                                                                    true;
                                                                print(
                                                                    isdeleteallowu);
                                                                // Home().check("Allow is pressed");
                                                                allowdelete(
                                                                    isdeleteallowu);
                                                                todelete();

                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Home(email: email),
                                                                        ));
                                                              })
                                                            });
                                                  });
                                                },
                                                child: Text(
                                                  "Allow",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlue[300]),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('emails')
                                                        .doc(id)
                                                        .update({
                                                      'isdeleteAllowed': false
                                                    }).then((_) => {
                                                              setState(() {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'emails')
                                                                    .doc(id)
                                                                    .update({
                                                                  'isdeleteAllowed':
                                                                      false
                                                                });
                                                                isdeleteallowu =
                                                                    false;
                                                                print(
                                                                    isdeleteallowu);
                                                                // Home().check("Allow is pressed");
                                                                allowdelete(
                                                                    isdeleteallowu);
                                                                todelete();

                                                                Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Home(email: email),
                                                                        ));
                                                              })
                                                            });
                                                  });
                                                },
                                                child: Text(
                                                  "Deny",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )));
                    },
                  );
                }
              },
            ))
            /* ,*/
          ],
        ),
      ),
    );
  }
}
