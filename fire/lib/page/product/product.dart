import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/firebase/firestore.dart';
import 'package:fire/page/admin/newproduct.dart';
import 'package:fire/page/product/Item2.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  Map<String, dynamic> userdata;
  String userid;
  ProductList(this.userdata, this.userid,{Key? key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final Firestore firestore = Firestore();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        General_Screen(widget.userdata,widget.userid)));
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.getproduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List productlist = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: width * 0.03, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                ),
                itemCount: productlist.length,
                itemBuilder: (context, index) {
                  // Get each product
                  DocumentSnapshot document = productlist[index];
                  String docId = document.id;
                  // Get data from each document
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String name = data['Name'];
                  double price = data['Price'];
                  int amount = data['Amount'];
                  String description = data['Desciption'];
                  String imageURL = data['ImageUrl'];
                  String id = data['Id'];
                  String size = data['Size'];
                  return Item2(
                      imageURL, name, price, amount, description, id, size);
                },
              ),
            );
          } else {
            return const Center(
              child:
                  CircularProgressIndicator(), // Show a loading indicator if data is loading
            );
          }
        },
      ),
    );
  }
}
