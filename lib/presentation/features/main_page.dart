// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:urbandrive/domain/user_authentication/user_auth_helper.dart';
import 'package:urbandrive/presentation/booking/pages/activivty_screen.dart';
import 'package:urbandrive/presentation/home_screen/pages/home_screen.dart';
import 'package:urbandrive/presentation/features/settings/pages/settings_screen.dart';
import 'package:urbandrive/presentation/support/pages/support_screen.dart';
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
                backgroundColor:  Colors.white,
                margin: EdgeInsets.all(15),
                selectedItemColor: Colors.blue,
                //  type: BottomNavigationBarType.fixed,
                currentIndex: state.index,
                // iconSize: 32,
                //showUnselectedLabels: true,
                items: [
                  SalomonBottomBarItem(
                      icon: ImageIcon(
                          AssetImage('lib/assets/images/unhome.png'),
                          size: 30,
                              color: Colors.blue,
                          ),
                          
                      title: Text('Home'),
                      activeIcon: ImageIcon(
                          AssetImage('lib/assets/images/home.png'),
                          size: 30,
                            color: Colors.blue,
                          )),
                  SalomonBottomBarItem(
                      activeIcon: ImageIcon(
                          AssetImage('lib/assets/images/activityIcon.png'),
                          size: 30),
                      icon: ImageIcon(
                        AssetImage('lib/assets/images/unactivityIcon.png'),
                        color: Colors.blue,
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
                          color: Colors.blue,
                      ),
                      title: Text('Support')),
                  SalomonBottomBarItem(
                      activeIcon: ImageIcon(
                        AssetImage('lib/assets/images/settings.png'),
                        size: 30,
                          color: Colors.blue,
                      ),
                      icon: ImageIcon(
                        AssetImage(
                          'lib/assets/images/unsettings.png',
                        ),
                        size: 30,
                          color: Colors.blue,
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
