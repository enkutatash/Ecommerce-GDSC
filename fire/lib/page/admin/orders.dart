import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/firebase/firestore.dart';
import 'package:fire/page/admin/item3.dart';
import 'package:fire/page/admin/newproduct.dart';
import 'package:fire/page/product/Item2.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  Map<String, dynamic> userdata;
  String userid;
  OrderList(this.userdata, this.userid, {Key? key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final Firestore firestore = Firestore();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        General_Screen(widget.userdata, widget.userid)));
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.getorder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List orderlist = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: ListView.builder(
                itemCount: orderlist.length,
                itemBuilder: (context, index) {
                  // Get each product
                  DocumentSnapshot document = orderlist[index];
                  String docId = document.id;
                  // Get data from each document
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  Map<String, dynamic> owner = data['OrderedBy'];
                  Map<String, dynamic> product = data['Product'];

                  return Order(owner, product);
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

class Order extends StatelessWidget {
  Map<String, dynamic> owner;
  Map<String, dynamic> product;
  Order(this.owner, this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.6,
      height: height * 0.15,
      color: const Color(0XFFF8F7F7),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product['ImageUrl'],
                 height: height * 0.13,
                  width: width * 0.34,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('${product['Name']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Text('\$ ${product['Price']}')
              ],
            ),
             ElevatedButton(
                      onPressed:(){},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF6055D8)
                          ,padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),),
                      child: Text(
                        "Track Order",
                        style: TextStyle(color: Colors.white),
                      ), // Add your button text here
                    ),
          ],
        ),
      ),
    );
  }
}
