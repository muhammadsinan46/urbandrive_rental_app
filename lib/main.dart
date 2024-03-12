import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/booking_confirmed_bloc/booking_confirm_bloc.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/application/dropoff_location_bloc/dropoff_location_bloc.dart';
import 'package:urbandrive/application/hom_screen_bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/application/pickup_location_bloc/location_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/profile_image_bloc/profileimage_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/Userauth/user_verify.dart';
import 'package:urbandrive/domain/booking_repo.dart';
import 'package:urbandrive/domain/cardata_repo.dart';
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
        // BlocProvider(create: (context) => BookingConfirmBloc(BookingRepo()),)
      ],
      child: MaterialApp(
        // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: UserVarify(),
      ),
    );
  }
}
