// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/activivty_screen.dart';
import 'package:urbandrive/presentation/pages/home_screen.dart';

import 'package:urbandrive/presentation/pages/settings_screen.dart';
import 'package:urbandrive/presentation/pages/support_screen.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key});

  String logUser = FirebaseAuth.instance.currentUser!.uid;
  UserauthHelper userh = UserauthHelper();


  List<Widget> _screens =[
    HomeScreen(),
    ActivityScreen(),
    SupportScreen(),
    SettingsScreen()

    
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: _screens[0],
      bottomNavigationBar:   BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        iconSize: 32,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.splitscreen), label: 'Activity'),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: 'Support'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          // setState(() {
          //   _selectedIndex = index;
          //   title = _titles[index];
          // });
        },
      ),
    );
  }
}
