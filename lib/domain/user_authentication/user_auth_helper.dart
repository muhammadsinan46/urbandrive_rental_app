// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urbandrive/presentation/features/main_page.dart';

class UserauthHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  BuildContext? context;
  User? user;

  String? userId;
  // get user => auth.currentUser;

  //google signin
  Future signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await auth.signInWithCredential(credential);

        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;

        await firestore.collection("users").doc(user!.uid).set({
          "uid": user.uid,
          "name": user.displayName,
          "email": user.email,
          "profile": user.photoURL,
          "location-status": false
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
            (route) => false);
      }
    } catch (e) {
      print("exception is :$e");
    }
  }

  //signup

  Future<UserCredential?> signUp({
    //  required String id,
    required String email,
    required String password,
    required String userName,
    // required String mobile,
  }) async {
    //final userid = auth.currentUser!.uid;

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //add data into user collection
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(userName);
        await firestore.collection("users").doc(auth.currentUser!.uid).set({
          "uid": auth.currentUser!.uid,
          "name": userName,
          "email": email,
          "location-status": false
          // "mobile": mobile,
        });
      }
      userId = auth.currentUser!.uid;
      return userCredential;
    } catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          // duration: Duration(seconds: 1),
          backgroundColor: Colors.grey[400],
          content: Text('Profile updated successfully')));
      return null;
    }
  }
  //signin

  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger(
            child: SnackBar(content: Text("This user does does not exist")));
      }

      throw Exception(e.code);
    }
  }

  forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  //signout
  Future signOut() async {
    await auth.signOut();
    print("signout");
  }


  deleteAccount()async{

    try{

      await auth.currentUser!.delete();

    }on FirebaseAuthException catch(e){

      print(e.toString());

    }
    

  }
}
