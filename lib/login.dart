import 'package:firebaseownpractice/signup.dart';
import 'package:flutter/material.dart';
import 'Function/functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool show_pass = true;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
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
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email ', prefixIcon: Icon(Icons.email)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passcontroller,
                    obscureText: show_pass,
                    decoration: InputDecoration(
                        hintText: 'Password ',
                        suffixIcon: TextButton(
                          child: Text(
                            "Show Password",
                            style: TextStyle(color: Colors.lightBlue[100]),
                          ),
                          onPressed: () {
                            setState(() {
                              if (show_pass == true) {
                                show_pass = false;
                              } else if (show_pass == false) {
                                show_pass = true;
                              }
                            });
                          },
                        ),
                        prefixIcon: Icon(Icons.password)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            signin(_emailcontroller, _passcontroller, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
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
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signup(),
                              ));
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(color: Colors.lightBlue[200]),
                        ),
                      )
                    ],
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
