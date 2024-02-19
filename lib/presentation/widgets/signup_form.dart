import 'package:flutter/material.dart';
import 'package:urbandrive/application/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/mainpage/mainpage.dart';
import 'package:urbandrive/presentation/pages/signup/signup_page.dart';
import 'package:urbandrive/presentation/widgets/google_widget.dart';
import 'package:urbandrive/presentation/widgets/text_form_field.dart';





class SignupForm extends StatelessWidget {
  const SignupForm({
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: const Text(
            "Create Account",
            style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, top: 25, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        suffixIconColor:
                            const Color.fromARGB(255, 191, 191, 191),
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: Icon(Icons.close),
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
                        hintText: "Full name"),
                  ),
                ),
                SizedBox(height: 20),
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
                const SizedBox(height: 20),
                InputTextField(passwordController: passwordController),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
    
                      UserauthHelper()
                          .signUp(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        if (value == null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MainPage()));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: Text(
                            value,
                            style: const TextStyle(fontSize: 16),
                          )));
                        }
                      });
                    }
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 20, bottom: 20),
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
                const GoogleWidget()
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
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => SignupPage())),
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

