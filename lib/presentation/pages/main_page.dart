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
  MainPage({Key? key,
  


   });

  // double? lat;
  // double? long;




 String logUser = FirebaseAuth.instance.currentUser!.uid;

  UserauthHelper userh = UserauthHelper();



  @override
  Widget build(BuildContext context) {
    //print("user logged is ${logUser}");

     List<Widget> _screens = [
    HomeScreen(),
    ActivityScreen(
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
    SupportScreen(),
    SettingsScreen()
  ];
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        if (state is BottomNavChageState) {
          return Scaffold(
            body: _screens[state.index],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Card(
              margin: EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              child: SalomonBottomBar(
                curve: Curves.decelerate,
                backgroundColor:  Colors.blue,
                margin: EdgeInsets.all(15),
                selectedItemColor: Colors.white,
                //  type: BottomNavigationBarType.fixed,
                currentIndex: state.index,
                // iconSize: 32,
                //showUnselectedLabels: true,
                items: [
                  SalomonBottomBarItem(
                      icon: ImageIcon(
                          AssetImage('lib/assets/images/unhome.png'),
                          size: 30,
                              color: Colors.white,
                          ),
                          
                      title: Text('Home'),
                      activeIcon: ImageIcon(
                          AssetImage('lib/assets/images/home.png'),
                          size: 30,
                            color: Colors.white,
                          )),
                  SalomonBottomBarItem(
                      activeIcon: ImageIcon(
                          AssetImage('lib/assets/images/activityIcon.png'),
                          size: 30),
                      icon: ImageIcon(
                        AssetImage('lib/assets/images/unactivityIcon.png'),
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text('Activity')),
                  SalomonBottomBarItem(
                      activeIcon: ImageIcon(
                        AssetImage('lib/assets/images/support.png'),
                        size: 30,
                      ),
                      icon: ImageIcon(
                        AssetImage('lib/assets/images/unsupport.png'),
                        size: 30,
                          color: Colors.white,
                      ),
                      title: Text('Support')),
                  SalomonBottomBarItem(
                      activeIcon: ImageIcon(
                        AssetImage('lib/assets/images/settings.png'),
                        size: 30,
                          color: Colors.white,
                      ),
                      icon: ImageIcon(
                        AssetImage(
                          'lib/assets/images/unsettings.png',
                        ),
                        size: 30,
                          color: Colors.white,
                      ),
                      title: Text('Settings')),
                ],
                onTap: (index) {
                  context
                      .read<BottomNavBloc>()
                      .add(BottomNavChageEvent(index: index));
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
