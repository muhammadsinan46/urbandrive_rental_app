// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:urbandrive/domain/Userauth/formvalidator.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/main_page.dart';
import 'package:urbandrive/presentation/pages/signup_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  UserauthHelper userauth = UserauthHelper();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'lib/assets/images/luke-chesser-pJadQetzTkI-unsplash.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset('lib/assets/images/lj-removebg-preview.jpg'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, right: 150),
                    child: const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 25, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 5,
                          child: TextFormField(  
                            cursorColor: Colors.black,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => FormValidator().validateEmail(value),
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconColor: const Color.fromARGB(255, 191, 191, 191),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 18.0, right: 18),
                                child: Icon(Icons.mail),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 79, 107, 158)),
                              ),
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 191, 191, 191),
                              ),
                              hintText: "Email"
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Card(
                          elevation: 5,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            validator: (value) => FormValidator().validatePassword(value),
                            controller: passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconColor: const Color.fromARGB(255, 191, 191, 191),
                              prefixIcon: const Icon(Icons.lock),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 79, 107, 158)),
                              ),
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 191, 191, 191),
                              ),
                              hintText: "Password"
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 280),
                          child: TextButton(
                            onPressed: () {
                              userauth.forgotPassword(emailController.text);
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white, fontSize: 15)
                            )
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: LoadingAnimationWidget.stretchedDots(color: Colors.black, size: 50)
                                  );
                                }
                              );
                              User? user = await userauth.signIn(
                                email: emailController.text,
                                password: passwordController.text
                              );
                              if (user != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => MainPage()),
                                  (route) => false
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("data"))
                                );
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            height: 45,
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18
                                  ),
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
                          onTap: () => userauth.signInWithGoogle(context),
                          child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            height: 50,
                            width: 220,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'lib/assets/images/pngegg.png',
                                  width: 20,
                                  height: 20,
                                ),
                                const Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignupPage())
                        ),
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}