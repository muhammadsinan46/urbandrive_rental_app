// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:urbandrive/domain/utils/user_authentication/formvalidation_helper.dart';
import 'package:urbandrive/domain/utils/user_authentication/user_auth_helper.dart';
import 'package:urbandrive/infrastructure/user_model/user_model.dart';
import 'package:urbandrive/presentation/location_screen/pages/location_permission_screen.dart';
import 'package:urbandrive/presentation/user_auth_screen/pages/login_screen.dart';
import 'package:urbandrive/presentation/user_auth_screen/widgets/google_widget.dart';

class SignupForm extends StatefulWidget {
  SignupForm(
      {super.key,
      required GlobalKey<FormState> formKey,
      required this.nameController,
      required this.emailController,
      required this.passwordController,
      // required this.mobileController,
      required this.currentLocation})
      : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  // final TextEditingController mobileController;
  final String currentLocation;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  UserauthHelper userauth = UserauthHelper();

  final firestore = FirebaseFirestore.instance;

  final fireauth = FirebaseAuth.instance.currentUser;

  bool isHidden = true;

  togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  UserModel? userdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 120,
            width: 120,
            child: Image.asset('lib/assets/images/udlogo.png')),
        Container(
          //  color: Colors.redAccent,
          margin: const EdgeInsets.only(top: 50, right: 150),
          child: const Text(
            "Create Account",
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 25, right: 15),
          child: Form(
            key: widget._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (value) =>
                        FormValidator().validatename("Full name", value),
                    controller: widget.nameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        prefixIcon: Icon(Icons.person_2_outlined),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          // borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158)),
                          //  borderRadius: BorderRadius.circular(30)
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 191, 191, 191),
                        ),
                        hintText: "Full name"),
                  ),
                ),
                SizedBox(height: 10),
                // Card(
                //   color: Colors.white,
                //   child: IntlPhoneField(
                //     dropdownTextStyle: const TextStyle(fontSize: 15),
                //     style: const TextStyle(fontSize: 15),
                //     controller: widget.mobileController,
                //     decoration: InputDecoration(

                //         filled: true,
                //         fillColor: Colors.white,
                //         prefixIconColor:
                //             const Color.fromARGB(255, 191, 191, 191),

                //         prefixIcon: Icon(Icons.email_outlined),

                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white),
                //           // borderRadius: BorderRadius.circular(30)
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //               color: Color.fromARGB(255, 79, 107, 158)),
                //           //  borderRadius: BorderRadius.circular(30)
                //         ),
                //         hintStyle: TextStyle(
                //           color: Color.fromARGB(255, 191, 191, 191),
                //         ),
                //         hintText: "Mobile number"),
                //     initialCountryCode: 'IN',
                //     onChanged: (phone) {},
                //   ),
                // ),
                SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (value) => FormValidator().validateEmail(value),
                    controller: widget.emailController,
                    decoration: InputDecoration(
                        //  errorStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        suffixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        prefixIcon: Icon(Icons.email_outlined),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          // borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158)),
                          //  borderRadius: BorderRadius.circular(30)
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 191, 191, 191),
                        ),
                        hintText: "Email"),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) =>
                        FormValidator().validatePassword(value),
                    controller: widget.passwordController,
                    decoration: InputDecoration(
                        //  errorStyle: TextStyle(color: Colors.white),
                        filled: isHidden ? true : false,
                        fillColor: Colors.white,
                        prefixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        suffixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: GestureDetector(
                          onTap: togglePassword,
                          child: Icon(isHidden
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          // borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158)),
                          //  borderRadius: BorderRadius.circular(30)
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 191, 191, 191),
                        ),
                        hintText: "Password"),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (widget._formKey.currentState!.validate()) {
                      try {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                  child: LoadingAnimationWidget.stretchedDots(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      size: 50));
                            });
                        await userauth.signUp(
                          userName: widget.nameController.text.trim(),
                          email: widget.emailController.text.trim(),
                          //  mobile: widget.mobileController.text,
                          password: widget.passwordController.text,

                          // id: fireauth!.uid
                        );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              
                               LocationPermissionScreen(
                                currentUser: userauth.userId!,
                              ),
                            ));
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: 250,
                    child: Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                    onTap: () {
                      UserauthHelper().signInWithGoogle(context);
                    },
                    child: const GoogleWidget())
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "already have an account?",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // const SizedBox(
            //   width: 5,
            // ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ],
    );
  }
}
