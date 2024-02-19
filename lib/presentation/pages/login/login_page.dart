import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:urbandrive/presentation/pages/signup/signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // FirebaseAuth auth = FirebaseAuth.instance;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String? completenumber;

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
              actions: [TextButton(onPressed: () {}, child: Text("skip"))],
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset(
                            'lib/assets/images/lj-removebg-preview.jpg')),
                    Container(
                      //  color: Colors.redAccent,
                      margin: const EdgeInsets.only(top: 50, right: 150),
                      child: Text(
                        "Welcome Back!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top:25, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIconColor:
                                      const Color.fromARGB(255, 191, 191, 191),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 18),
                                    child: Icon(Icons.mail),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 79, 107, 158)),
                                      borderRadius: BorderRadius.circular(30)),
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 191, 191, 191),
                                  ),
                                  hintText: "Email"),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIconColor:
                                      const Color.fromARGB(255, 191, 191, 191),
                                  prefixIcon: Icon(Icons.lock),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 79, 107, 158)),
                                      borderRadius: BorderRadius.circular(30)),
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 191, 191, 191),
                                  ),
                                  hintText: "Password"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 45,
                              width: 120,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Login",
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
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(30)),
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
                                      fontSize: 18),
                                ),
                                // Icon(Icons.arrow_forward)
                              ],
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
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignupPage())),
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
