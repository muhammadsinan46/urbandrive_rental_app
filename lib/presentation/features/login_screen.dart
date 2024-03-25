// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:urbandrive/domain/user_authentication/formvalidator.dart';
import 'package:urbandrive/domain/user_authentication/user_auth_helper.dart';
import 'package:urbandrive/presentation/features/main_page.dart';
import 'package:urbandrive/presentation/features/signup_screen.dart';
import 'package:urbandrive/presentation/widgets/google_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  UserauthHelper userauth = UserauthHelper();


bool isHidden = true;

    togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }


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
                  Container(
                    
                    height: 120,
                    width: 120,
                    child: Image.asset('lib/assets/images/udlogo.png',),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, right: 150),
                    child: const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
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
                            obscureText: isHidden? true:false,
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
                              suffixIcon:  GestureDetector(
                          onTap: togglePassword,
                          child: Icon(isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility),
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
                        
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                userauth.forgotPassword(emailController.text);
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.white, fontSize: 14)
                              )
                            ),
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
                                    child: LoadingAnimationWidget.stretchedDots(color: const Color.fromARGB(255, 255, 255, 255), size: 50)
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
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            height: 60,
                            width: 250,
                            child: Center(
                              child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18
                                    ),
                                  ),
                            )
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () => userauth.signInWithGoogle(context),
                          child:GoogleWidget(),
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
