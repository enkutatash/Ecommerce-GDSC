import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  //get collection of notes
  final CollectionReference dbref =
      FirebaseFirestore.instance.collection('product');

  //create
  Future addproduct(String name, double price, int amount, String description,
      String imageUrl, String id) {
    return dbref.add({
      'Name': name,
      'Price': price,
      'Amount': amount,
      'Desciption': description,
      'Id': id,
      
    });
  }

  //update
  Future<void> updateproduct(String docid, String name, String des,
      double price, int Amount, String id) {
    return dbref.doc(docid).update({
      'Name': name,
      'Desciption': des,
      'Amount': Amount,
      'Price': price,
      'id': id
    });
  }

  //read
  Stream<QuerySnapshot> getproduct() {
    final productlist = dbref.orderBy('Name').snapshots();
    return productlist;
  }

  //delete
  Future<void> deleteproduct(String docid) {
    return dbref.doc(docid).delete();
  }
}
