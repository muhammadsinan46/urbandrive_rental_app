// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:urbandrive/infrastructure/user_model.dart';
import 'package:urbandrive/presentation/widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



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
              actions: [
                TextButton(onPressed: () {}, child: const Text("skip"))
              ],
            ),
            body: SingleChildScrollView(
              child: SignupForm(
                  formKey: _formKey,
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  mobileController: mobileController,
                  currentLocation: "Adreess",
                  ),
            )),
      ],
    );
  }
}
