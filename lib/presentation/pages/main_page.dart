// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/home_screen.dart';
import 'package:urbandrive/presentation/pages/profile_screen.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key});

  String logUser = FirebaseAuth.instance.currentUser!.uid;
  UserauthHelper userh = UserauthHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowProfileScreen()));
            },
            icon: const Icon(Icons.person)
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false
            );
          },
          child: Text("Sign Out")
        )
      ),
    );
  }
}
