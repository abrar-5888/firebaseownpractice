import 'package:flutter/material.dart';
import 'Function/functions.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool showPass = true;
  bool showConfirmPass = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_add,
                size: 64,
                color: Colors.white,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
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
                controller: passController,
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
              SizedBox(height: 16),
              TextFormField(
                controller: confirmPassController,
                obscureText: showConfirmPass,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  suffixIcon: TextButton(
                    child: Text(
                      showConfirmPass ? 'Show Password' : 'Hide Password',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        showConfirmPass = !showConfirmPass;
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
              ElevatedButton(
                onPressed: () {
                  Create_Account(emailController, passController,
                      confirmPassController, context);
                },
                child: Text("Create Account"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber[300],
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
                      backgroundColor: Colors.blueGrey[300]),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
