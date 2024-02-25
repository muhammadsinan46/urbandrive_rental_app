import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:urbandrive/infrastructure/user_model.dart';

class UserRepository {
    User? user =FirebaseAuth.instance.currentUser;

  Future <UserModel> getUser()async{
       print("object arguing");
try{
  print("object");
    final userdata = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();

    final data = userdata.data();
    print("user repo ${user!.uid}");
      print("data is validating ${data}");
    final users = UserModel(id: data!['uid'],email: data['email'],name: data['name'],
     mobile: data['mobile'], profile: data['profile']
    
    );
  print("users are here.... ${users}");

    return users;
} on FirebaseException catch(e){

  if(kDebugMode){
    print(e.message);
  }

  return UserModel(id: "", name: "", email: "");
}
catch(e){
  throw Exception(e.toString());
}



    
  }


  // Future<List<UserModel>> getUser() async {

  //   List<UserModel> userdata = [];

  //   User ? user = FirebaseAuth.instance.currentUser;

  //   try {
  
  //     final users = await FirebaseFirestore.instance.collection("users").where('uid',isEqualTo: user!.uid).get();

  //     users.docs.forEach((element) {
  //       print("current id ${FirebaseAuth.instance.currentUser!.uid}");
  //       print("taken ${element.data()}");
  //       return userdata.add(UserModel.fromJson(element.data()));
  //     });
  //     print("user details....");
  //     return userdata;
  //   } on FirebaseException catch (e) {
  //     if (kDebugMode) {
  //       print("Failed with error ${e.code}: ${e.message}");
  //     }
  //     return userdata;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
