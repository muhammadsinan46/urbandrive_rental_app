// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/application/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/login/login_page.dart';

class MainPage extends StatelessWidget {
   MainPage({super.key});

   FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: (){
        UserauthHelper().signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      }, icon: const Icon(Icons.power_settings_new))],),
      body: Center(child: 
     
        Text("${auth.currentUser!.email}" )
      ),
    );
  }
}