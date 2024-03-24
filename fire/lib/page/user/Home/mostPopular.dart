import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/firebase/firestore.dart';
import 'package:fire/page/user/Home/Item.dart';
import 'package:fire/page/product/product.dart';

class MostPopular extends StatefulWidget {
  Map<String, dynamic> userdata;
  String userid;
  MostPopular(this.userdata,this.userid, {Key? key}) : super(key: key);

  @override
  _MostPopularState createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  final Firestore firestore = Firestore();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Most Popular",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductList(widget.userdata,widget.userid)));
              },
              child: Text(
                "see all",
                style: TextStyle(fontSize: 16, color: Color(0XFF6055D8)),
              ),
            )
          ],
        ),
        SizedBox(
          height: height * 0.25,
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore.getproduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List productlist = snapshot.data!.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(width * 0.05),
                  itemCount: 3,
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Item(
                          imageURL, name, price, amount, description, id, size),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
