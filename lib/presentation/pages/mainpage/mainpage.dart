// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:urbandrive/presentation/pages/profile/profile_page.dart';

class MainPage extends StatelessWidget {
   MainPage({super.key});

   FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen()));
        }, icon: const Icon(Icons.person))
      ],),
      body: Center(child: 
     
        // Text("${auth.currentUser!.email}" ),
        Text("hhhhhhhhhhhh")
      ),
    );
  }
}