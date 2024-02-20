// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urbandrive/presentation/pages/mainpage/mainpage.dart';

class UserauthHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

 // get user => auth.currentUser;



  //google signin
  Future signInWithGoogle(BuildContext context)async{
    // print("clicked");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      // print("1");
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      // print("2");
      if(googleSignInAccount !=  null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      // print("3");
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
        );
        // print("4");
        await auth.signInWithCredential(credential);
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  MainPage(),), (route) => false);
      }
    }
    catch(e){
        print("exception is : $e");
}}

  //signup
  Future<User?> signUp({ required String email, required String password}) async {
    try {
     UserCredential credential= await auth.createUserWithEmailAndPassword(email: email, password: password);

      return credential.user;
      
    } on FirebaseAuthException catch (e) {
     print(e.message);
    }

    return null;
  }

  //signin

  Future<User?> signIn({required String email, required String password}) async {
    try {
         UserCredential credential=await  auth.signInWithEmailAndPassword(email: email, password: password);

         return credential.user;
    } on FirebaseAuthException catch (e) {
       throw Exception(e.message);
  }
  
  }

   forgotPassword(String email)async{

    await auth.sendPasswordResetEmail(email: email);
   }

    //signout
  Future signOut() async {
    await auth.signOut();
    print("signout");
  }
}


