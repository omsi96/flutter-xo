import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void register(
    {required String name,
    required String email,
    required String password,
    required VoidCallback success}) async {
  var auth = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      _createProfile(userCredential.user!.uid, name, email);
    } else {
      throw ErrorSummary("Couldn't create user to the database");
    }
    print("You are signed up successfully");

    success();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

void _createProfile(String uid, String name, String email) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Call the user's CollectionReference to add a new user
  return await users
      .doc(uid)
      .set({
        'name': name,
        'email': email,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

void signIn(String email, String password, VoidCallback success) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    success();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
