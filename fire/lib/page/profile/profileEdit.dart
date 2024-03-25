import 'dart:io';

import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/profile/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {
  Map<String, dynamic> userdata;
  String userid;

  ProfileEdit(this.userdata, this.userid, {super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late final Firebase_auth_service _auth;
  TextEditingController? userName;
  TextEditingController? password;
  // TextEditingController? _imagePathController;
  String? downloadUrl;
  String? imagePath;
  File? _image;
  String? oldpassword;

  @override
  void initState() {
    // TODO: implement initState
    oldpassword = widget.userdata['password'];
    _auth = Firebase_auth_service(context);
    imagePath = widget.userdata['profilePic'];
    downloadUrl = widget.userdata['profilePic'];
    userName = TextEditingController(text: widget.userdata['userName']);
    password = TextEditingController(text: widget.userdata['password']);
    userName!.addListener(_onChanged);
    password!.addListener(_onChanged);
    // _imagePathController =TextEditingController(text:widget.userdata['profilePic']);
    // _imagePathController!.addListener(_onChanged);
    super.initState();
  }

  void _onChanged() {
    widget.userdata['userName'] = userName!.text;
    widget.userdata['password'] = password!.text;
     widget.userdata['profilePic'] = imagePath;
    print(widget.userdata['userName']);
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
              Stack(alignment: AlignmentDirectional.center, children: [
                CircleAvatar(
                    radius: 40.0, backgroundImage: NetworkImage(imagePath!)),
                Positioned(
                  top: 75,
                  right: -8,
                  child: IconButton(
                      onPressed: pickImage,
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                        color: Color(0XFF6055D8),
                      )))
              ]),
              Text(
                "UserName",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              textfield("username", Icons.person_4_outlined, userName!,
                  TextInputType.text,
                  suffixIcon: Icons.done),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Password",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              textfield("*********", Icons.lock_outline, password!,
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
                      onPressed: () {
                        _auth.updateprofile(
                            widget.userid,
                            widget.userdata['Email'],
                            widget.userdata['userName'],
                            widget.userdata['password'],
                            widget.userdata['profilePic']);
                        _auth.updatePassword(widget.userid, oldpassword!,
                            widget.userdata['password']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                    widget.userdata, widget.userid)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF6055D8)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 60.0),
                            child: Text(
                              "Change",
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
                ],
              ),
            ],
          ),
        ),
      )),
    );
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
}
