import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/firebase/firestore.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  final Firestore firestore = Firestore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List productlist = snapshot.data!.docs;
            return ListView.builder(
              itemCount: productlist.length,
              itemBuilder: (context, index) {
                //get each product
                DocumentSnapshot document = productlist[index];
                String docId = document.id;
                //get data from each docu
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String name = data['Name'];
                double price = data['Price'];
                int amount = data['Amount'];
                String description = data['Desciption'];
                return ListTile(
                  
                  leading: Text(name),
                  title: Text('$amount'),
                  subtitle: Text('$price'),
                  trailing: IconButton(
                      onPressed: () {
                        firestore.deleteProduct(docId);
                      },
                      icon: Icon(Icons.delete)),
                );
              },
            );
          } else {
            return const Text("no item");
          }
        },
      ),
    );
  }
}
