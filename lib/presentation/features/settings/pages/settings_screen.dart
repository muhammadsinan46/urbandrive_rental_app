import 'dart:async';

import 'package:flutter/material.dart';
import 'package:urbandrive/domain/user_authentication/user_auth_helper.dart';
import 'package:urbandrive/presentation/features/login_screen.dart';
import 'package:urbandrive/presentation/features/settings/widgets/favourite_car_card.dart';
import 'package:urbandrive/presentation/features/settings/widgets/user_profile_card.dart';
import 'package:urbandrive/presentation/features/signup_screen.dart';
import 'package:url_launcher/url_launcher.dart';

UserauthHelper userauthHelper = UserauthHelper();

class SettingsScreen extends StatefulWidget {
   SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
   final Uri _termsUri = Uri.parse('https://www.termsfeed.com/live/b66d72da-619d-4a95-8a46-5899c89f16f2');
   final Uri _privacyUrl =Uri.parse('https://www.termsfeed.com/live/00b2ed95-10e2-404b-9516-08f578c73774');

      Future<void> termsCondition()async{
        if(!await launchUrl(_termsUri)){

          throw Exception('could not launch $_termsUri');
        }


  }
        Future<void> privacyPolicy()async{
        if(!await launchUrl(_privacyUrl)){

          throw Exception('could not launch $_privacyUrl');
        }


  }

  @override
  Widget build(BuildContext context) {

 



    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 245, 255),
      appBar: AppBar(backgroundColor: Colors.blue,),
      body: Column(
       
        children: [
             SizedBox(height: 20,),
          UserProfileCard(),
          SizedBox(height: 50,),
          Card(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)    ,   color: Colors.white,),
       
                height: 350,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    FavouriteCarCard(),
                         Divider(color: const Color.fromARGB(255, 233, 245, 255),),

               
                    ListTile(
                      onTap: () => privacyPolicy(),
                      leading:ImageIcon(AssetImage('lib/assets/images/privacyicon.png',)) ,
                      title: Text("Privacy Policy",),
                     
                     
                    ),
                    Divider(color: const Color.fromARGB(255, 233, 245, 255),),
                      
                    ListTile(
                      onTap: () => termsCondition(),
                      leading: ImageIcon(AssetImage('lib/assets/images/termsicon.png')),
                      title: Text("Terms and Conditions"),
                     
                    ),
                         Divider(color: const Color.fromARGB(255, 233, 245, 255),),
                
                    ListTile(
                      onTap: () {
                          showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                backgroundColor:  Color.fromARGB(255, 193, 229, 254),
                                title: Text("Log out"),
                                content:Text("Are you sure ?") ,
                                actions: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                      height: 40,width: 100,child: Center(child: Text("Cancel")),)),
                                  InkWell(
                                    onTap: () {
                                         userauthHelper.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (route) => false,
                        );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
                                      height: 40,width: 100,child: Center(child: Text("Log out", style: TextStyle(color: Colors.white),)),)),
                                ],
                              );
                          },);
                              
                     
                      },
                      leading:ImageIcon(AssetImage('lib/assets/images/logout.png')),
                      title: Text("Logout"),
                     
                    ),
                         Divider(color: const Color.fromARGB(255, 233, 245, 255),),
                
                    ListTile(
                       onTap: () => showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                backgroundColor:  Color.fromARGB(255, 193, 229, 254),
                                title: Text("Delete your account"),
                                content:Text("Are you sure you want to delete your account ?") ,
                                actions: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                      height: 40,width: 100,child: Center(child: Text("Cancel")),)),
                                  InkWell(
                                    onTap: () {
                                        userauthHelper.deleteAccount();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                          (route) => false,
                        );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
                                      height: 40,width: 100,child: Center(child: Text("Delete", style: TextStyle(color: Colors.white),)),)),
                                ],
                              );
                          },),
                      leading:ImageIcon(AssetImage('lib/assets/images/delaccount.png')),
                      title: Text("Delete My Account"),
                      
                    ),
                
                  ],
                )),
          )
        ],
      ),
    );
  }
}


