import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:urbandrive/domain/Userauth/formvalidator.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/login/login_page.dart';
import 'package:urbandrive/presentation/pages/mainpage/mainpage.dart';

import 'package:urbandrive/presentation/widgets/google_widget.dart';

class SignupForm extends StatelessWidget {
  SignupForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  UserauthHelper userauth = UserauthHelper();
  final firestore = FirebaseFirestore.instance;
  final fireauth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 120,
            width: 120,
            child: Image.asset('lib/assets/images/lj-removebg-preview.jpg')),
        Container(
          //  color: Colors.redAccent,
          margin: const EdgeInsets.only(top: 50, right: 150),
          child: const Text(
            "Create Account",
            style: TextStyle(
                color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 25, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: TextFormField(
                    validator: (value) =>
                        FormValidator().validatename("Full name", value),
                    controller: nameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        suffixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: IconButton(
                          onPressed: () {
                            nameController.clear();
                          },
                          icon: Icon(Icons.close),
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
                        hintText: "Full name"),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) => FormValidator().validateEmail(value),
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIconColor: const Color.fromARGB(255, 191, 191, 191),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Icon(Icons.mail),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158)),
                          borderRadius: BorderRadius.circular(30)),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 191, 191, 191),
                      ),
                      hintText: "Email"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) => FormValidator().validatePassword(value),
                  controller: passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIconColor: const Color.fromARGB(255, 191, 191, 191),
                      prefixIcon: const Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158)),
                          borderRadius: BorderRadius.circular(30)),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 191, 191, 191),
                      ),
                      hintText: "Password"),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      try {
                        //               await userauth.signUp(
                        //                         email: emailController.text,
                        //                         password: passwordController.text);
                        //                    await firestore.collection("Users").doc(fireauth!.uid).set({
                        //                       //"uid": fireauth!.uid,
                        //                       "Name": nameController.text,
                        //                       "Email": emailController.text,
                        //                     }).then((value){
                        //                         Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MainPage()),
                        //   (route) => false,
                        // );

                        //                     });
                        final Userfound = await userauth.signUp(
                            userName: emailController.text,
                            email: emailController.text,
                            password: passwordController.text);
                        final User = fireauth!.uid;
                        if (Userfound != null) {
                          print("user found");

                          print(User);
                          await firestore.collection("newuser").doc(User).set({
                            "Name": nameController.text,
                            "Email": emailController.text,
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                            (route) => false,
                          );
                        }
                      } catch (e) {
                        print('Error navigating to MainPage: $e');
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    height: 45,
                    width: 120,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
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
