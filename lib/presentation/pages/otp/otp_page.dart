import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:urbandrive/presentation/pages/mainpage/mainpage.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key, required this.varId});

  String varId;

  final otpController = TextEditingController();
  final focusNode = FocusNode();

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
                        height: 100,
                        width: 100,
                        child: Image.asset(
                            'lib/assets/images/lj-removebg-preview.jpg')),
                    Container(
                      //  color: Colors.redAccent,
                      margin: const EdgeInsets.only(top: 70, right: 150),
                      child: Text(
                        "Verify",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        //  margin:const  EdgeInsets.only(top: 200),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10)),
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Pinput(
                                  length: 6,
                                  controller: otpController,
                                  focusNode: focusNode,
                                
                                )),
                            GestureDetector(
                              onTap: () async {
                                try {
                                  PhoneAuthCredential credential =
                                      await PhoneAuthProvider.credential(
                                          verificationId: varId,
                                          smsCode:
                                              otpController.text.toString());
                                              FirebaseAuth.instance.signInWithCredential(credential).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainPage())));
                                } catch (e) {
                                    log(e.toString() as num);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 20, left: 250, bottom: 20),
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
                                      "Sign Up",
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
