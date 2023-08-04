import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseownpractice/Function/functions.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    String? goname = FirebaseAuth.instance.currentUser?.displayName;
    String? goimage = FirebaseAuth.instance.currentUser?.photoURL;
    String? goemail = FirebaseAuth.instance.currentUser?.email;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.orange,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "${goimage}",
                            height: 80,
                            width: 80,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('${goname}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                        SizedBox(
                          height: 3,
                        ),
                        Text('${goemail}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Page 1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // Handle the click for Page 1
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Page 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // Handle the click for Page 2
                    },
                  ),
                  // Add more list tiles for other pages if needed
                ],
              ),
            ),
          ),
          Material(
            elevation: 10,
            shadowColor: Colors.black87,
            color: Colors.yellow[800],
            child: ListTile(
              tileColor: Colors.white.withOpacity(0.2),
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                signout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
