import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/bottom_nav_bloc/bottom_nav_bloc.dart';


import 'package:urbandrive/application/dropoff_location_bloc/dropoff_location_bloc.dart';
import 'package:urbandrive/application/specific_category_bloc/specific_category_list_bloc.dart';
import 'package:urbandrive/domain/repository/favourite_repo/favourite_repo.dart';
import 'package:urbandrive/application/favourite_bloc/favourite_bloc.dart';
import 'package:urbandrive/application/search_bloc/search_bloc.dart';
import 'package:urbandrive/presentation/search_screen/search_repo.dart';
import 'package:urbandrive/application/homescreen_bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/application/pickup_location_bloc/location_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/profile_image_bloc/profileimage_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/utils/user_authentication/user_verification_helper.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';

import 'package:urbandrive/domain/repository/car_data_repo/cardata_repo.dart';
import 'package:urbandrive/domain/repository/location_repo/location_repo.dart';

import 'package:urbandrive/domain/repository/user_repo/user_repository.dart';
import 'package:urbandrive/domain/utils/profile/profile_image_helper.dart';





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
        BlocProvider(create: (context) => SpecificCategoryBloc(CardataRepo()),),
   


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
