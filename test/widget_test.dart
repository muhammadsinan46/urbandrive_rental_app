// Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                         height: 100,
//                         width: 100,
//                         child: Image.asset(
//                             'lib/assets/images/lj-removebg-preview.jpg')),
//                     Container(
//                       //  color: Colors.redAccent,
//                       margin: const EdgeInsets.only(top: 70, right: 150),
//                       child: Text(
//                         "",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 45,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Container(
//                         //  margin:const  EdgeInsets.only(top: 200),
//                         decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 255, 255, 255),
//                             borderRadius: BorderRadius.circular(10)),
//                         height: 450,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: TextFormField(
//                                 decoration: const InputDecoration(
//                                     prefixIcon: Icon(Icons.person),
//                                     hintText: "Full name"),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: TextFormField(
//                                 decoration: const InputDecoration(
//                                     icon: Icon(Icons.mail), hintText: "Email"),
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: IntlPhoneField(
//                                 initialCountryCode: 'IN',
//                                 decoration:
//                                     InputDecoration(hintText: "mobile number"),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OtpPage(varId: ,)));
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.only(
//                                     top: 20, left: 250, bottom: 20),
//                                 decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 height: 45,
//                                 width: 120,
//                                 child: const Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       "Sign Up",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 18),
//                                     ),
//                                     Icon(
//                                       Icons.arrow_forward,
//                                       color: Colors.white,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const Divider(),
//                             Container(
//                               margin:
//                                   const EdgeInsets.only(top: 20, bottom: 20),
//                               decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 154, 153, 157),
//                                   borderRadius: BorderRadius.circular(30)),
//                               height: 50,
//                               width: 220,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Image.asset(
//                                     'lib/assets/images/pngegg.png',
//                                     width: 20,
//                                     height: 20,
//                                   ),
//                                   const Text(
//                                     "Continue with Google",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 18),
//                                   ),
//                                   // Icon(Icons.arrow_forward)
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "already have an account?",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         TextButton(
//                           onPressed: () => Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage())),
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),