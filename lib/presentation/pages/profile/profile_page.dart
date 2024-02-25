import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firestorage;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrive/application/bloc/profileimage/profileimage_bloc.dart';
import 'package:urbandrive/application/bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';

import 'package:urbandrive/infrastructure/user_model.dart';
import 'package:urbandrive/presentation/pages/login/login_page.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  final mobileController = TextEditingController();
  final dlcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  UserauthHelper userh = UserauthHelper();
  CollectionReference reference =
      FirebaseFirestore.instance.collection('Users');

  final userAuth = FirebaseAuth.instance.currentUser;

  File? imageFile;

  String? birthdate;
  DateTime? dbdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {

        
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
                              child: BlocBuilder<ProfileimageBloc, ProfileimageState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ProfileimageBloc>()
                                          .add(UploadImageEvent());
                                    },
                                    child: BlocBuilder<ProfileimageBloc,
                                        ProfileimageState>(
                                      builder: (context, profilestate) {
                                        if (state.file != null) {}
                                        return CircleAvatar(
                                            child: Container(
                                          child: state.file != null
                                              ? Image.file(
                                                  File(state.file!.path))
                                              : Icon(Icons.add_a_photo),
                                        )

                                            //
                                            // NetworkImage(widget.user!.photoURL!)
                                            );
                                      },
                                    ),
                                  );
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
                          GestureDetector(
                            // onTap: () async {
                            //   if (_formKey.currentState!.validate() &&
                            //        != null) {
                            //     print("loading2.....");

                            //     firestorage.Reference ref = firestorage
                            //         .FirebaseStorage.instance
                            //         .ref('/foldername' '123');
                            //     firestorage.UploadTask uploadTask =
                            //         ref.putFile(File(state.file!.path));
                            //     Future.value(uploadTask).then((value) async {
                            //       var newUrl = await ref.getDownloadURL();
                            //       print(newUrl);
                            //       Map<String, dynamic> datas = {
                            //         "Mobile": mobileController.text,
                            //         "Profile": newUrl
                            //       };
                            //       await reference
                            //           .doc(userAuth!.uid)
                            //           .update(datas);
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(
                            //               duration: Duration(seconds: 1),
                            //               backgroundColor: Colors.grey[400],
                            //               content: Text(
                            //                   'Profile updated successfully')));
                            //     });
                            //   }
                            // },
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
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          userh.signOut();
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
        },
      ),
    );
  }
}
 // ListView.builder(
            //   itemCount: userdata.length,
            //   itemBuilder: (context, index) {
            //     return Form(
            //       key: _formKey,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           margin: EdgeInsets.only(top: 50),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: Color.fromARGB(72, 142, 172, 255),
            //           ),
            //           height: 500,
            //           width: 400,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               SizedBox(
            //                   height: 150,
            //                   width: 150,
            //                   child: BlocBuilder<ProfileimageBloc,
            //                       ProfileimageState>(
            //                     builder: (context, profilestate) {
            //                       // mobileController.text = userdata[index].mobile!;
            //                       // profilestate.file = userdata[index].profile;
            //                       return GestureDetector(
            //                         onTap: () {
            //                           context
            //                               .read<ProfileimageBloc>()
            //                               .add(UploadImageEvent());
            //                         },
            //                         child: CircleAvatar(
            //                             backgroundImage: profilestate.file !=
            //                                     null
            //                                 ? FileImage(
            //                                     File(profilestate.file!.path))
            //                                 : null,
            //                             child: userdata[index].profile != null
            //                                 ? Image.network(
            //                                     userdata[index].profile!)
            //                                 : Icon(Icons.add_a_photo)),
            //                       );
            //                     },
            //                   )),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               Container(
            //                 width: 350,
            //                 height: 50,
            //                 padding: EdgeInsets.only(left: 10, top: 8),
            //                 decoration: BoxDecoration(border: Border.all()),
            //                 child: Text(
            //                   userdata[index].name,
            //                   // "${user!.displayName}",
            //                   style: TextStyle(fontSize: 18),
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 5,
            //               ),
            //               SizedBox(
            //                 width: 350,
            //                 height: 70,
            //                 child: IntlPhoneField(
            //                   dropdownTextStyle: const TextStyle(fontSize: 15),
            //                   style: const TextStyle(fontSize: 18),
            //                   controller: mobileController,
            //                   decoration: InputDecoration(
            //                     border: const OutlineInputBorder(),
            //                     hintStyle: TextStyle(
            //                         color: Color.fromARGB(255, 113, 113, 113)),
            //                     hintText: userdata[index].mobile,
            //                     //   labelText: "Mobile number",
            //                     // user!.phoneNumber ?? "Phone number",
            //                   ),
            //                   initialCountryCode: 'IN',
            //                   onChanged: (phone) {},
            //                 ),
            //               ),
            //               Container(
            //                 width: 350,
            //                 height: 50,
            //                 padding: const EdgeInsets.only(left: 10, top: 8),
            //                 decoration: BoxDecoration(border: Border.all()),
            //                 child: Text(
            //                   userdata[index].email,
            //                   //"${user!.email}",
            //                   style: const TextStyle(fontSize: 18),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               BlocBuilder<ProfileimageBloc, ProfileimageState>(
            //                 builder: (context, profilestate) {
            //                   print("this updat${profilestate.file}");
            //                   return GestureDetector(
            //                     onTap: () async {
            //                       print(profilestate.file);
            //                       if (_formKey.currentState!.validate() &&
            //                           profilestate.file != null) {
            //                         firestorage.Reference ref = firestorage
            //                             .FirebaseStorage.instance
            //                             .ref('/foldername' '123');
            //                         firestorage.UploadTask uploadTask = ref
            //                             .putFile(File(profilestate.file!.path));
            //                         Future.value(uploadTask)
            //                             .then((value) async {
            //                           var newUrl = await ref.getDownloadURL();
            //                           print("new path is: ${newUrl}");
            //                           Map<String, dynamic> datas = {
            //                             "mobile": mobileController.text,
            //                             "profile": newUrl
            //                           };
            //                           print("data is validating ${datas}");
            //                           await reference
            //                               .doc(userAuth!.uid)
            //                               .update(datas)
            //                               .then((value) =>
            //                                   mobileController.clear());

            //                           //    context.read<SubjectBloc>()
            //                           context
            //                               .read<UsersBloc>()
            //                               .add(GetUserEvent());
            //                           // ScaffoldMessenger.of(context).showSnackBar(
            //                           //     SnackBar(
            //                           //         duration: Duration(seconds: 1),
            //                           //         backgroundColor: Colors.grey[400],
            //                           //         content: Text(
            //                           //             'Profile updated successfully')));
            //                         });
            //                       }
            //                     },
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(10),
            //                         color: Colors.black,
            //                       ),
            //                       width: 150,
            //                       height: 60,
            //                       child: const Center(
            //                           child: Text(
            //                         "UPDATE PROFILE",
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.bold),
            //                       )),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //     // Card(
            //     //   child: ListTile(
            //     //     title: Text(userdata[index].name),
            //     //     subtitle: Text(userdata[index].email),
            //     //   ),
            //     // );
            //   },
            // );

