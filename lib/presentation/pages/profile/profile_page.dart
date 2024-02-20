import 'package:dob_input_field/dob_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/login/login_page.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  final mobileController = TextEditingController();
  UserauthHelper userh = UserauthHelper();

  String? birthdate;
  DateTime? dbdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 500,
          width:400,
            color: Color.fromARGB(74, 201, 201, 201),
            child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(),
                ),
                Text("User name",style: TextStyle(fontSize: 18),),
                Container(
                  width: 350,
                  height: 70,
                  child: IntlPhoneField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: mobileController.text,
                      labelText: "Phone number",
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {},
                  ),
                ),
                Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Text("${user!.email}"),
                ),

       Container(
        height: 50,
        width: 300,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      child: Text("User name",style: TextStyle(fontSize: 18, color: Colors.white),)),
                TextButton(
                    onPressed: () {
                      userh.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text("Signout")),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
