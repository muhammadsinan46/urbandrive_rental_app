import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrive/application/bloc/profileimage/profileimage_bloc.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/login/login_page.dart';
import 'package:urbandrive/presentation/widgets/profile_picker.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  final mobileController = TextEditingController();
  final dlcontroller = TextEditingController();
  UserauthHelper userh = UserauthHelper();
  CollectionReference reference =   FirebaseFirestore.instance.collection('Users');

    File ? imageFile;
  // Uint8List? proImage;

  String? birthdate;
  DateTime? dbdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
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
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: ProfilePicker(imageFile: imageFile, user: user),
                          ),
                          // BlocBuilder<ProfileimageBloc, ProfileimageState>(
                          //   builder: (context, state) {
                          //     return TextButton(
                          //         onPressed: () {
                          //           uploadImage(context);
                                   
                          //         },
                          //         child: Text(
                          //           "Edit Image",
                          //           style: TextStyle(
                          //               color: const Color.fromARGB(
                          //                   255, 2, 121, 218)),
                          //         )
                          //         );
                          //   },
                          // ),
                        ],
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
                          "${user!.displayName}",
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
                          dropdownTextStyle: const TextStyle(fontSize: 22),
                          style: const TextStyle(fontSize: 22),
                          controller: mobileController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: mobileController.text,
                            labelText: user!.phoneNumber ?? "Phone number",
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
                          "${user!.email}",
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        width: 150,
                        height: 60,
                        child: Center(
                            child: Text(
                          "UPDATE PROFILE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      userh.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: Text("Sign Out"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadImage( context) async {
   final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }

    imageFile = File(file.path);
   // String image = ;
   // proImage = Imagefile as Uint8List;

    // BlocProvider.of<ProfileimageBloc>(context).add(UploadImageEvent(userImage: imageFile!));
  }
}

