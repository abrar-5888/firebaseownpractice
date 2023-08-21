import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Function/functions.dart';
import '../signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPass = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.lock_outline,
              size: 64,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email, color: Colors.white),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passController,
              obscureText: showPass,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock, color: Colors.white),
                suffixIcon: TextButton(
                  child: Text(
                    showPass ? 'Show Password' : 'Hide Password',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signin(_emailController, _passController, context);
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber[300],
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(color: Colors.lightBlue[200]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  signingoogle(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color.fromARGB(255, 206, 206, 206)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/google.png"),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Continue with Google",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  signInWithFacebook();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color.fromARGB(255, 206, 206, 206)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/facebook.png"),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Continue with FaceBook",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
