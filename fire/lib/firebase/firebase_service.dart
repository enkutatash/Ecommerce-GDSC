import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Firebase_auth_service {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference dbrefuser =
      FirebaseFirestore.instance.collection('User');
  late BuildContext _context;

  Firebase_auth_service(BuildContext context) {
    _context = context;
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  Future adduser(String userid, String email, String userName, String password,
      String profilePic) {
    return dbrefuser.doc(userid).set({
      'Email': email,
      'userName': userName,
      'password': password,
      'profilePic': profilePic
    });
  }

  Future<void> updatePassword(String uid, String oldpassword,String newPassword) async {
    try {
      // Retrieve user based on UID
      User? user = FirebaseAuth.instance.currentUser;
      print("current user");

      if (user != null) {
        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: oldpassword);
         user.reauthenticateWithCredential(credential);
        print("After");
         user.updatePassword(newPassword);
        print('Password updated successfully');
      } else {
        print('User not signed in.');
      }
    } catch (error) {
      print('Error updating password: $error');
      throw error; // Rethrow the error to handle it in the calling function
    }
  }

  Future<void> updateprofile(String userid, String email, String userName,
      String password, String profilePic) {
    return dbrefuser.doc(userid).update({
      'Email': email,
      'userName': userName,
      'password': password,
      'profilePic': profilePic,
    });
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String userName, String password, String profilePic) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? userid = user.user?.uid;
      adduser(userid!, email, userName, password, profilePic);
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The email address is already in use.');
        _showSnackBar('The email address is already in use.');
      } else {
        print('An error occurred: ${e.code}');
        _showSnackBar('An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print('Invalid email or password.');
        _showSnackBar('Invalid email or password.');
      } else {
        print('An error occurred: ${e.code}');
        _showSnackBar('An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<Map<String, dynamic>> data(String docid) async {
    try {
      DocumentSnapshot snapshot = await dbrefuser.doc(docid).get();
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

  void signout() {
    FirebaseAuth.instance.signOut();
  }
}
