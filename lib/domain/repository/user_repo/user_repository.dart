import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:urbandrive/infrastructure/user_model/user_model.dart';

class UserRepository {
    User? user =FirebaseAuth.instance.currentUser;

  Future <UserModel> getUser()async{

try{

    final userdata = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();

    final data = userdata.data();

    final users = UserModel(id: data!['uid'],email: data['email'],name: data['name'],
   //  mobile: data['mobile'],
      profile: data['profile'],
      location: data['location'],
      locationStatus: data['location-status']

    
    );


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


}
