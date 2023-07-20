// import 'package:firebase/firebase.dart';
// import 'package:firebaseownpractice/Function/functions.dart';
import 'package:flutter/material.dart';
import './home.dart';
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

  bool isupdateallowu = true;
  bool isdeleteallowu = true;

  @override
  Widget build(BuildContext context) {
    // void _handleAllowButtonPressed() {
    //   setState(() {
    //     isbutonallow = true; // Set the variable to true when "Allow" is pressed
    //   });
    //   Navigator.pop(
    //       context, isbutonallow); // Return the variable value to home.dart
    // }

    // void _handleDenyButtonPressed() {
    //   isbutonallow = false;
    //   Navigator.pop(
    //       context, isbutonallow); // Return the variable value to home.dart
    // }
    //   Navigator.pop(context, false);
    // }

    String email = widget.email;
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: Column(
          children: [
            Text(
              "User email = ${email}",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                height: 0,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Update",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isupdateallowu = true;
                          // Home().check("Allow is pressed");
                          allowupdate(isupdateallowu);
                          to();

                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Allow",
                        style: TextStyle(color: Colors.lightBlue[300]),
                      )),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isupdateallowu = false;
                          allowupdate(isupdateallowu);
                          to();
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Deny",
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                height: 0,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isdeleteallowu = true;
                          // Home().check("Allow is pressed");
                          // allowdelete();
                        });
                      },
                      child: Text(
                        "Allow",
                        style: TextStyle(color: Colors.lightBlue[300]),
                      )),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isdeleteallowu = false;
                          // Home().check("Allow is pressed");
                          // allowdelete();
                        });
                      },
                      child: Text(
                        "Deny",
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
