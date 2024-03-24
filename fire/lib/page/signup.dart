// import 'dart:ffi';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/signin.dart';

class SignUp_Screen extends StatefulWidget {
  SignUp_Screen({super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  // final Firebase_auth_service _auth = Firebase_auth_service();
  late final Firebase_auth_service _auth;

  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  String imagePath = "assets/profile_pic.png";
  File? _image;
  String? downloadUrl;

  bool ischecked = false;

  @override
  void initState() {
    _auth = Firebase_auth_service(context);
    super.initState();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    // For mobile platforms, set the image directly
    final imageTemp = File(image.path);
    setState(() {
      imagePath = imageTemp.path;
      _image = imageTemp;
    });
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now()}.jpg');

    try {
      // Upload the image to Firebase Storage
      await storageReference.putFile(_image!);

      // Retrieve the download URL of the uploaded image
      downloadUrl = await storageReference.getDownloadURL();
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $e');
    }
  }

  @override
  void dispose() {
    email.dispose();
    username.dispose();
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
              const Text("Getting Started",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(
                "Create an account to continue",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: Stack(children: [
                  CircleAvatar(
                      radius: 40.0, backgroundImage: AssetImage(imagePath)),
                  Positioned(
                      top: 45,
                      right: -10,
                      child: IconButton(
                          onPressed: pickImage,
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                            color: Color(0XFF6055D8),
                          )))
                ]),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Email",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              textfield(
                "example@gmail.com",
                Icons.email_outlined,
                email,
                TextInputType.emailAddress,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Username",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              textfield("username", Icons.person_4_outlined, username,
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
                height: height * 0.03,
              ),
              Row(
                children: [
                  Checkbox(
                    value: ischecked,
                    onChanged: (bool? value) {
                      setState(() {
                        ischecked = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("By creating an account, you agree to our "),
                        Text(
                          "Terms & Conditions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.05,
                    width: width * 0.6,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF6055D8)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 60.0),
                            child: Text(
                              "Signup ",
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
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn_Screen()));
                        },
                        child: const Text(
                          "Sign in",
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

  void _signUp() async {
    String UserName = username.text;
    String Email = email.text;
    String Password = password.text;

    User? user = await _auth.signUpWithEmailAndPassword(
        Email, UserName, Password, downloadUrl!);
    if (user != null) {
      print("User is successfully created");
      Map<String, dynamic> userdata = {
        'Email': email,
      'userName': UserName,
      'password': password,
      'profilePic': downloadUrl
      };
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => General_Screen(userdata, user.uid)));
      _showSnackBar("User is successfully created");
    } else {
      print("Some error happend on create user");
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
