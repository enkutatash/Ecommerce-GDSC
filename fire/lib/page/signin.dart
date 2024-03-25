// import 'dart:ffi';

import 'package:fire/page/admin/adminFront.dart';
import 'package:fire/page/front.dart';
import 'package:fire/page/admin/newproduct.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/signup.dart';

class SignIn_Screen extends StatefulWidget {
  SignIn_Screen({super.key});

  @override
  State<SignIn_Screen> createState() => _SignIn_ScreenState();
}

class _SignIn_ScreenState extends State<SignIn_Screen> {
  late final Firebase_auth_service _auth;
  late Map<String, dynamic> userdata;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();

  bool ischecked = false;

  @override
  void initState() {
    _auth = Firebase_auth_service(context);
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: height * 0.05, left: width * 0.1, right: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("Lets's sign you in",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Text(
                "Welcome back",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Email",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              textfield("username", Icons.person_4_outlined, email,
                  TextInputType.text,
                  suffixIcon: Icons.done),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Password",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              textfield("*********", Icons.lock_outline, password,
                  TextInputType.visiblePassword,
                  suffixIcon: Icons.visibility_outlined),
              SizedBox(
                height: height * 0.4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.05,
                    width: width * 0.6,
                    child: ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF6055D8)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 60.0),
                            child: Text(
                              "Sign In ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ), // Add your button text here
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?  "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp_Screen()));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Color(0XFF6055D8)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some action to take when the user presses the action button
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      userdata = await _auth.data(userId);
    } catch (e) {
      // Handle error
    }
  }

  void _signIn() async {
    String Email = email.text;
    String Password = password.text;

    User? user = await _auth.signInWithEmailAndPassword(Email, Password);

    if (user != null) {
      print("User is successfully Sign in");
      print("userid");
      print(user.uid);
     await _fetchUserData(user.uid);
      if (Email == "admin@gmail.com") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminFront()));
        _showSnackBar("Admin is successfully Sign in");
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => General_Screen(userdata, user.uid)));
        _showSnackBar("User is successfully Sign in");
      }
    } else {
      print("Some error happend on login user");
      _showSnackBar("Some error happend on create user");
    }
  }
}

Widget textfield(
  String hint,
  IconData icon,
  TextEditingController controller,
  TextInputType keyboardType, {
  IconData? suffixIcon,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontStyle: FontStyle.italic,
      ),
      prefixIcon: Icon(icon),
      suffixIcon: (suffixIcon != null) ? Icon(suffixIcon) : null,
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0XFF6055D8)),
      ),
    ),
  );
}
