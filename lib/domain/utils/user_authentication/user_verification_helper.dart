import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/presentation/user_auth_screen/pages/login_screen.dart';
import 'package:urbandrive/presentation/main_page/pages/main_page.dart';

class UserVarify extends StatelessWidget {
  const UserVarify({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: ((context, snapshot){
        if(snapshot.connectionState ==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else if (snapshot.hasError){
          return const Center(child: Text("Something not right"),);
        }else if(snapshot.hasData){
          return  MainPage();
        }else{
          return LoginPage();
        }

      })),
    );
  }
}