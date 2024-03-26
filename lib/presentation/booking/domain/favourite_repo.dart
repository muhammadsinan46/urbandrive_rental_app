import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/presentation/booking/data_sources/fav_model.dart';

// class FavouriteRepo {
//   final firestore = FirebaseFirestore.instance;
//   addFavourte(CarModels carmodels) async {
//     final FirebaseAuth auth = FirebaseAuth.instance;

//     final userId = auth.currentUser!.uid;

//     final favId = firestore.collection('favourites').doc().id;

//     final modelCollection =
//         await firestore.collection('models').doc(carmodels.id).get();

//     //   bool  isExist =await isFavExist(carmodels.id);

//     // if(isExist){
//     //   throw Exception("package is already exist");
//     // }

//     final data = await isFavExist(carmodels.id);
//     print("values data is ${data}");

//     Map<String, dynamic> favdata = {
//       "uid": userId,
//       "favId": favId,
//       "car_model": modelCollection.data()
//     };

//     await firestore.collection('favourites').doc(favId).set(favdata);
//   }

//   Future<List<FavouriteModel>> getFavourite() async {
//     List<FavouriteModel> favList = [];

//     try {
//       final favcollection = await firestore.collection('favourites').get();

//       favcollection.docs.forEach((element) {
//         final data = element.data();

//         final favData = FavouriteModel(
//             userId: data['uid'],
//             favId: data['favId'],
//             carmodel: data['car_model']);

//         favList.add(favData);
//       });

//       return favList;
//     } on FirebaseException catch (e) {
//       print("fav error is ${e.message}");
//       return favList;
//     }
//   }

//   removeFavourite(String favId) async {
//     await firestore.collection('favourites').doc(favId).delete();
//   }

//   //Future<bool>
//   isFavExist(String carId) async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     final favSnapshot = await firestore
//         .collection('favourites')
//         .where('id', isEqualTo: carId)
//         .where('uid', isEqualTo: auth.currentUser!.uid)
//         .get();

//     return favSnapshot.docs.isEmpty;
//   }
// }

class FavouriteRepo {
  final firestore = FirebaseFirestore.instance;

  Future<void> addFavourite(CarModels carmodels) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    final favId = firestore.collection('favourites').doc().id;
    final modelCollection = await firestore.collection('models').doc(carmodels.id).get();

    // Check if car already exists in favorites for the current user
    final isExist = await isFavExist(carmodels.id, carmodels.id);

    if (isExist) {
      throw Exception("Car model already exists in favorites");
    }

    final data = {
      "uid": userId,
      "favId": favId,
      "car_model": modelCollection.data(),
    };

    await firestore.collection('favourites').doc(favId).set(data);
  }

  Future<List<FavouriteModel>> getFavourite() async {
    List<FavouriteModel> favList = [];

    try {
      final favcollection = await firestore.collection('favourites').get();

      favcollection.docs.forEach((element) {
        final data = element.data();

        final favData = FavouriteModel(
          userId: data['uid'],
          favId: data['favId'],
          carmodel: data['car_model'],
        );

        favList.add(favData);
      });

      return favList;
    } on FirebaseException catch (e) {
      print("fav error is ${e.message}");
      return favList;
    }
  }

  Future<bool> isFavExist( String userId, String carmodelId) async {
    final favSnapshot = await firestore
        .collection('favourites')
        .where('id', isEqualTo: carmodelId)
        .where('uid', isEqualTo: userId)
        .get();

    return favSnapshot.docs.isNotEmpty;
  }

  removeFavourite(String favId) async {
    await firestore.collection('favourites').doc(favId).delete();

    
  }
}

