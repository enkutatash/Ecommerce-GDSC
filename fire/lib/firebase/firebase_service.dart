import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Firebase_auth_service {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late BuildContext _context;

  Firebase_auth_service(BuildContext context) {
    _context = context;
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
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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

  void signout() {
    FirebaseAuth.instance.signOut();
  }
}
