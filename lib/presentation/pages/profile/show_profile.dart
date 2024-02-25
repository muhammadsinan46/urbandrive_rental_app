import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrive/application/bloc/profileimage/profileimage_bloc.dart';
import 'package:urbandrive/application/bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/infrastructure/user_model.dart';
import 'package:urbandrive/presentation/pages/login/login_page.dart';

class ShowProfileScreen extends StatefulWidget {
  const ShowProfileScreen({super.key});

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
  CollectionReference reference =
      FirebaseFirestore.instance.collection('Users');

  final userAuth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          print(state);
          if (state is UsersLoadedState) {
            UserModel userdata = state.users;
            mobileController.text = userdata.mobile!;
            print("usermobile ${userdata.mobile}");
            print("user image ${userdata.profile}");
            // print("state image ${userdata.profile}");

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
                                            ? Icon(Icons.add_a_photo)
                                            : CircleAvatar(
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
                                            backgroundImage: FileImage(File(
                                                pstate.file!.path.toString()))),
                                      );
                                    }
                                  },
                                )),
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
                                dropdownTextStyle:
                                    const TextStyle(fontSize: 22),
                                style: const TextStyle(fontSize: 22),
                                controller: mobileController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: mobileController.text,
                                    labelText: userdata.mobile),
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
                                    String newUrl = await ref.getDownloadURL();
                                    print(newUrl);
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userAuth!.uid)
                                        .update({
                                      'name': 'Farhu',
                                      'mobile': mobileController.text,
                                      // 'profile':newUrl
                                    });
                                    // upadateProfile(pstate.file!,userdata);
                                    // print('hellow function');
                                    context
                                        .read<UsersBloc>()
                                        .add(GetUserEvent());
                                  },
                                  child: Container(
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
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
                                    builder: (context) => LoginPage()),
                                (route) => false);
                          },
                          child: Text("Sign Out"))
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

  Future<void> upadateProfile(XFile imageFile, UserModel userModel) async {
    if (imageFile != null) {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/foldername' + '1224');
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(imageFile.path.toString()));
      await uploadTask;
      String newUrl = await ref.getDownloadURL();
      print(newUrl);

      userModel.profile = newUrl;
      userModel.mobile = mobileController.text;
    }
    print("model to json${userModel.toJson()}");
    FirebaseFirestore.instance
        .collection('users')
        .doc(userAuth!.uid)
        .update({'name': 'Farhu'});
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
  // upadateProfile(BuildContext conext, String imgpath) async {
  //   File file = File(imgpath);

  //   firestorage.Reference ref =
  //       firestorage.FirebaseStorage.instance.ref("profile${userAuth!.uid}");
  //   firestorage.UploadTask uploadTask = ref.putFile(file);
  //      await uploadTask;
  //   try {

  //     var imageurl = await ref.getDownloadURL();
  //     print("image addded ${imageurl}");
  //      print(mobileController.text);
  //     Map<String, dynamic> datas = {
  //       "id": FirebaseAuth.instance.currentUser!.uid,
  //       "mobile": mobileController.text,
  //       "profile": imageurl
  //     };
  //     print(userAuth!.uid);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(userAuth!.uid)
  //         .set(datas);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         duration: Duration(seconds: 1),
  //         backgroundColor: Colors.grey[400],
  //         content: Text('Profile updated successfully')));
  //     //  then((_) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)), (route) => false));
  //   } catch (e) {
  //     throw Exception("error uploading profile $e");
  //   }
  // }
}
