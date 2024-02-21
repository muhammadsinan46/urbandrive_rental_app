import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/bloc/profileimage/profileimage_bloc.dart';
import 'package:urbandrive/domain/Userauth/user_verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDI0326UzKvHzobej5FleBS-iVC9jwyg8s",
              appId: "1:626820479065:android:7c9efd471273eb85411948",
              messagingSenderId: "626820479065",
              projectId: "urban-drive-2a233"))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ProfileimageBloc(),
      child: MaterialApp(
        // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: UserVarify(),
      ),
    );
  }
}
