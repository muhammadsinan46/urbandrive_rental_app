import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrive/application/profile_screen_bloc/profile_image_bloc/profileimage_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/utils/user_authentication/user_auth_helper.dart';
import 'package:urbandrive/infrastructure/user_model/user_model.dart';
import 'package:urbandrive/presentation/user_auth_screen/pages/login_screen.dart';

class ShowProfileScreen extends StatefulWidget {
  const ShowProfileScreen({Key? key});

  @override
  State<ShowProfileScreen> createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  @override
  void initState() {
    context.read<UsersBloc>().add(GetUserEvent());
    super.initState();
  }

  UserauthHelper userauthHelper = UserauthHelper();

  final mobileController = TextEditingController();
  final dlcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final userAuth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
            
          if (state is UsersLoadedState) {
          //  print("user profile state is ${state.users.mobile}");
            UserModel userdata = state.users;
          //  mobileController.text = userdata.mobile!;

            return SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(72, 142, 172, 255),
                        ),
                        height: 600,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: BlocBuilder<ProfileimageBloc,
                                  ProfileimageState>(
                                builder: (context, pstate) {
                                  if (pstate.file == null) {
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ProfileimageBloc>()
                                            .add(UploadImageEvent());
                                      },
                                      child: userdata.profile == null
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.white,
                                           child:     Icon(Icons.add_a_photo) ,
                                                  )
                                          
                                     
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  userdata.profile!)),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ProfileimageBloc>()
                                            .add(UploadImageEvent());
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        backgroundImage: FileImage(File(
                                            pstate.file!.path.toString()))),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 350,
                              height: 50,
                              padding: EdgeInsets.only(left: 10, top: 8),
                              decoration: BoxDecoration(border: Border.all()),
                              child: Text(
                                userdata.name,
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 350,
                              height: 70,
                              child: IntlPhoneField(
                                flagsButtonMargin: EdgeInsets.only(top: 2),
                                dropdownTextStyle:
                                    const TextStyle(fontSize: 22, ),
                                style: const TextStyle(fontSize: 22),
                                controller: mobileController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 2),
                                    border: const OutlineInputBorder(),
                                  //  hintText: mobileController.text,
                                  //  labelText: userdata.mobile
                                    ),
                                initialCountryCode: 'IN',
                                onChanged: (phone) {},
                              ),
                            ),
                            Container(
                              width: 350,
                              height: 50,
                              padding: const EdgeInsets.only(left: 10, top: 8),
                              decoration: BoxDecoration(border: Border.all()),
                              child: Text(
                                userdata.email,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            BlocBuilder<ProfileimageBloc, ProfileimageState>(
                              builder: (context, pstate) {
                                return InkWell(
                                  onTap: () async {
                                    firebase_storage.Reference ref =
                                        firebase_storage
                                            .FirebaseStorage.instance
                                            .ref('/foldername' + '1224');
                                    firebase_storage.UploadTask uploadTask =
                                        ref.putFile(
                                            File(pstate.file!.path.toString()));
                                    await uploadTask;
                                    String newUrl =
                                        await ref.getDownloadURL();
                                    print(newUrl);
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userAuth!.uid)
                                        .update({
                                      'mobile': mobileController.text,
                                    });
                                    context
                                        .read<UsersBloc>()
                                        .add(GetUserEvent());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    width: 200,
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        "Update Profile",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          userauthHelper.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text("Sign Out"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is UsersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      elevation: 10,
      backgroundColor: Colors.white,
      content: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
