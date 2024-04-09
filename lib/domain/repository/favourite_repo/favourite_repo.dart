import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/infrastructure/favourite_model/fav_model.dart';


class FavouriteRepo {
  final firestore = FirebaseFirestore.instance;

  Future<void> addFavourite(CarModels carmodels) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;


    final modelCollection = await firestore.collection('models').doc(carmodels.id).get();

    // Check if car already exists in favorites for the current user
    final isExist = await isFavExist(carmodels.id, carmodels.id);

    if (isExist) {
      throw Exception("Car model already exists in favorites");
    }

    final data = {
      "uid": userId,
      "favId": carmodels.id,
      "car_model": modelCollection.data(),
    };

    await firestore.collection('favourites').doc(carmodels.id).set(data);
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

