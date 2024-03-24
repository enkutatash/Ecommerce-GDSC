// import 'dart:ffi';

import 'dart:io';
import 'package:fire/firebase/firestore.dart';
import 'package:fire/page/product/product.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProduct extends StatefulWidget {
  Map<String, dynamic> userdata;
  AddNewProduct(this.userdata,{super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  String? downloadUrl;
  final Firestore firestore = Firestore();
  String? _selectedSize;
  List<String> size = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
  ];

  final Name = TextEditingController();
  final Price = TextEditingController();
  final Description = TextEditingController();
  final Amount = TextEditingController();
  String? imagePath;
  File? _image;

  bool ischecked = false;

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
    Amount.dispose();
    Name.dispose();
    Price.dispose();
    Description.dispose();
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
              const Text("Add New Product",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: height * 0.03,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: height * 0.1,
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: pickImage,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              side: const BorderSide(
                                  color: Color(
                                      0XFF6055D8)), // Adjust border color here
                            ),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              color: Color(0XFF6055D8),
                            ),
                            Text(
                              "Upload picture",
                              style: TextStyle(color: Color(0XFF6055D8)),
                            ),
                          ],
                        ), // Add your button text here
                      ),
                    ),
                    imagePath != null
                        ? Image.file(
                            File(
                                imagePath!), // Assuming _imagePath holds the local file path
                            width: width * 0.4,
                            height: height * 0.1,
                          )
                        : const Text("No image selected"),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Text(
                "Product Name",
                style: TextStyle(color: Colors.black),
              ),
              textfield(
                "Nike shoes",
                Name,
                TextInputType.text,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Text(
                "Product Price",
                style: TextStyle(color: Colors.black),
              ),
              textfield("\$200", Price, TextInputType.number),
              SizedBox(
                height: height * 0.03,
              ),
              const Text(
                "Amount",
                style: TextStyle(color: Colors.black),
              ),
              textfield("1", Amount, TextInputType.number),
              SizedBox(
                height: height * 0.03,
              ),
              const Text(
                "Product Description",
                style: TextStyle(color: Colors.black),
              ),
              textfield("Description", Description, TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              const Text(
                "Product Size",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              DropdownButton<String>(
                value: _selectedSize,
                hint: const Text("Select Size"),
                items: size.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSize = newValue!;
                  });
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.07,
                    width: width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        String id = randomAlphaNumeric(10);
                        firestore.addproduct(
                          Name.text,
                          double.tryParse(Price.text) ??
                              0.0, // Convert to double or use 0.0 if conversion fails
                          int.tryParse(Amount.text) ??
                              0, // Convert to int or use 0 if conversion fails
                          Description.text,
                          _selectedSize!,
                          downloadUrl!, // Pass File object or null if _image is null
                          id,
                        );
                        Fluttertoast.showToast(
                            msg: "New Product is added",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => General_Screen(widget.userdata,"s6N7ql9YmxdMRu3oC2WDPWQoxvs2")));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF6055D8)),
                      child: Text(
                        "Add Product ",
                        style: TextStyle(color: Colors.white),
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


}

Widget textfield(
  String hint,
  TextEditingController controller,
  TextInputType keyboardType,
) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontStyle: FontStyle.italic,
      ),
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
