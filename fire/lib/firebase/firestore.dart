import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  //get collection of notes
  final CollectionReference dbref =
      FirebaseFirestore.instance.collection('product');
  final CollectionReference orderRef =
      FirebaseFirestore.instance.collection('Orders');
  

  //create
  Future addproduct(String name, double price, int amount, String description,
      String size, String imageUrl, String id) {
    return dbref.doc(id).set({
      'Name': name,
      'Price': price,
      'Amount': amount,
      'Desciption': description,
      'Size': size,
      'Id': id,
      'ImageUrl': imageUrl,
    });
  }

    Future<Map<String, dynamic>> data(String docid) async {
    try {
      DocumentSnapshot snapshot = await dbref.doc(docid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userdata = snapshot.data() as Map<String, dynamic>;
        return userdata;
      } else {
        return {}; // Return empty map if the document doesn't exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {}; // Return empty map if there's an error
    }
  }

 

  //update
  Future<void> updateproduct(String name, String des,
      double price, int Amount, String id,String size,String imageurl) {
    return dbref.doc(id).update({
      'Name': name,
      'Desciption': des,
      'Amount': Amount,
      'Price': price,
      'id': id,
      'Size':size,
      'ImageUrl':imageurl
    });
  }

  //read
  Stream<QuerySnapshot> getproduct() {
    final productlist = dbref.orderBy('Name').snapshots();
    return productlist;
  }

   Stream<QuerySnapshot> getorder() {
    final orderlist = orderRef.snapshots();
    return orderlist;
  }

  //delete
  Future<void> deleteproduct(String docid) {
    return dbref.doc(docid).delete();
  }
  //search
}
