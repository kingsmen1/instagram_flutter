import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/resourses/storage_methods.dart';

class AuthMethods {
  // first we create FirebaseAuth instance var.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Firestore instance var.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signUp Function
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = 'An erro has occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        final cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final userId = cred.user!.uid;
        print(userId);

        //Uploading Image
        final photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        /*add user to collection . It creates new collection and document if 
        its not theres before if its already there it overrides it .*/
        await _firestore.collection('users').doc(userId).set({
          'username': username,
          'uid': userId,
          'email': email,
          'bio': bio,
          'followeres': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        /* .add  just add a doc with auto Generated docId in the collection unlike 
        .doc(userId).set*/
        /*await _firestore.collection('users').add({
          'username': username,
          'uid': userId,
          'email': email,
          'bio': bio,
          'followeres': [],
          'following': [],
        });*/

        res = 'success';
      }
      // on FirebaseAuthException can be used to catch auth errors and can be used
      //to display detailed message to users
      /*on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The Email is badly formatted';
      }*/
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
