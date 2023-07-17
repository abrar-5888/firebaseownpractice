import 'package:flutter/material.dart';
import 'Function/functions.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool show_pass = true;
  bool show_pass1 = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController cpasscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email ', prefixIcon: Icon(Icons.email)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passcontroller,
                    obscureText: show_pass,
                    decoration: InputDecoration(
                        hintText: 'Password ',
                        suffixIcon: TextButton(
                          child: Text("Show Password",
                              style: TextStyle(color: Colors.lightBlue[100])),
                          onPressed: () {
                            setState(
                              () {
                                if (show_pass == true) {
                                  show_pass = false;
                                } else if (show_pass == false) {
                                  show_pass = true;
                                }
                              },
                            );
                          },
                        ),
                        prefixIcon: Icon(Icons.password)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cpasscontroller,
                    obscureText: show_pass1,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password ',
                        suffixIcon: TextButton(
                            child: Text("Show Password",
                                style: TextStyle(
                                  color: Colors.lightBlue[100],
                                )),
                            onPressed: () {
                              setState(
                                () {
                                  if (show_pass1 == true) {
                                    show_pass1 = false;
                                  } else if (show_pass1 == false) {
                                    show_pass1 = true;
                                  }
                                },
                              );
                            }),
                        prefixIcon: Icon(Icons.password)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Create_Account(emailcontroller, passcontroller,
                            cpasscontroller, context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[300]),
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
}
