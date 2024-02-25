// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/login/login_page.dart';


import 'package:urbandrive/presentation/pages/profile/profile_page.dart';
import 'package:urbandrive/presentation/pages/profile/show_profile.dart';

class MainPage extends StatelessWidget {
   MainPage({super.key});

   String logUser = FirebaseAuth.instance.currentUser!.uid;
     UserauthHelper userh = UserauthHelper();

   //Future<UserModel> getuserData
        //  final userdata =  FirebaseFirestore.instance
        //   .collection("Users").doc()
        //   // .doc()
        //   // .get();

   //final user =      UserData.getUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ShowProfileScreen()));
        }, icon: const Icon(Icons.person))
      ],),
      body: Center(child: 
     
       //  Text("${logUser.currentUser!.email}" ),
           ElevatedButton(
                        onPressed: () {
                          userh.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                        child: Text("Sign Out"))
      ),
    );
  }
}