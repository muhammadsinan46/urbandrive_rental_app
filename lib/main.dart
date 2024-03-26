import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/bottom_nav_bloc/bottom_nav_bloc.dart';


import 'package:urbandrive/application/dropoff_location_bloc/dropoff_location_bloc.dart';
import 'package:urbandrive/presentation/booking/domain/favourite_repo.dart';
import 'package:urbandrive/presentation/features/favourite/bloc/favourite_bloc.dart';
import 'package:urbandrive/presentation/features/search_screen/application/search_bloc/search_bloc.dart';
import 'package:urbandrive/presentation/features/search_screen/search_repo.dart';
import 'package:urbandrive/presentation/home_screen/bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/application/pickup_location_bloc/location_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/profile_image_bloc/profileimage_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/user_authentication/user_verify.dart';
import 'package:urbandrive/presentation/booking/bloc/car_booking_bloc/car_booking_bloc.dart';

import 'package:urbandrive/presentation/booking/domain/cardata_repo.dart';
import 'package:urbandrive/domain/location_repo.dart';

import 'package:urbandrive/domain/profileutils/user_repos.dart';
import 'package:urbandrive/domain/profileutils/profile_image.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDI0326UzKvHzobej5FleBS-iVC9jwyg8s",
              appId: "1:626820479065:android:7c9efd471273eb85411948",
              messagingSenderId: "626820479065",
              storageBucket: "urban-drive-2a233.appspot.com",
              projectId: "urban-drive-2a233")
              
              )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileimageBloc(ProfileImage()),
        ),
        BlocProvider(
          create: (context) => UsersBloc(UserRepository()),
        ),
        BlocProvider(create: (context) => HomescreenBloc(CardataRepo()),),
        BlocProvider(create: (context) => CarBookingBloc(CardataRepo()),),
        BlocProvider(create: (context) => LocationBloc(LocationRepo()),),
        BlocProvider(create: (context) => DropoffLocationBloc(LocationRepo()),),
        BlocProvider(create: (context) => BottomNavBloc(),),
        BlocProvider(create: (context) => SearchBloc(SearchRepo()),),
        BlocProvider(create: (context) => FavouriteBloc(FavouriteRepo()),),
   


        // BlocProvider(create: (context) => BookingConfirmBloc(BookingRepo()),)
      ],
      child: MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor:   const Color.fromARGB(255, 233, 245, 255),),
        // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home:  UserVarify(),
      ),
    );
  }
}
