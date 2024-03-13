// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/activivty_screen.dart';
import 'package:urbandrive/presentation/pages/home_screen.dart';

import 'package:urbandrive/presentation/pages/settings_screen.dart';
import 'package:urbandrive/presentation/pages/support_screen.dart';

import '../../application/bottom_nav_bloc/bottom_nav_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key});

  String logUser = FirebaseAuth.instance.currentUser!.uid;
  UserauthHelper userh = UserauthHelper();

  List<Widget> _screens = [
    HomeScreen(),
    ActivityScreen(),
    SupportScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {

        if(state is BottomNavChageState){

        return Scaffold(
          body: _screens[state.index],
          
          bottomNavigationBar: SalomonBottomBar(

            
            curve: Curves.decelerate,
            backgroundColor: Color.fromARGB(255, 250, 254, 255),
            margin: EdgeInsets.all(15),
            selectedItemColor: Colors.blue,
          //  type: BottomNavigationBarType.fixed,
            currentIndex: state.index,
           // iconSize: 32,
            //showUnselectedLabels: true,
            items:  [
              SalomonBottomBarItem(
                
                  icon: ImageIcon(AssetImage('lib/assets/images/unhome.png'),size: 30),
                  title: Text('Home'),
                  activeIcon:
                      ImageIcon(AssetImage('lib/assets/images/home.png'),size: 30)),
              SalomonBottomBarItem(
                     activeIcon:
                      ImageIcon(AssetImage('lib/assets/images/activityIcon.png'),size: 30),
                  icon: ImageIcon(
                      AssetImage('lib/assets/images/unactivityIcon.png'), size: 30,),
                  title: Text('Activity')),
              SalomonBottomBarItem(
                activeIcon:  ImageIcon(
                      AssetImage('lib/assets/images/support.png'), size: 30,),
                  icon:  ImageIcon(
                      AssetImage('lib/assets/images/unsupport.png'), size: 30,), title: Text('Support')),
              SalomonBottomBarItem(
                activeIcon: ImageIcon(
                      AssetImage('lib/assets/images/settings.png'), size: 30,) ,
                  icon: ImageIcon(
                     
                      AssetImage('lib/assets/images/unsettings.png',), size: 30,), title: Text('Settings')),
            ],
            onTap: (index) {
                  context.read<BottomNavBloc>().add(BottomNavChageEvent(index: index));
            },
          ),
        );
        }else{
        return Container();
        }

      },
    );
  }
}
