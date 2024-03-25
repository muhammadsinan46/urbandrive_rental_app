import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/presentation/booking/data_sources/fav_model.dart';

class FavouriteRepo {
  final firestore = FirebaseFirestore.instance;
  addFavourte(CarModels carmodels) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final userId = auth.currentUser!.uid;

    final favId = firestore.collection('favourites').doc().id;

    final modeldata = await firestore.doc(carmodels.id).get();

    Map<String, dynamic> favdata = {
      "uid": userId,
      "favId": favId,
      "car_model": modeldata
    };
    await firestore.doc(favId).set(favdata);
  }

  Future<List<FavouriteModel>> getFavourite() async {
    List<FavouriteModel> favList = [];

try{

      final favcollection = await firestore.collection('favourites').get();

    favcollection.docs.forEach((element) {
      final data = element.data();

      final favData = FavouriteModel(
          userId: data['uid'],
          favId: data['favId'],
          carmodel: data['car_model']);

      favList.add(favData);
    });

    return favList;
}on FirebaseException catch(e){
  

  print("fav error is ${e.message}");
      return favList;
}
  }


  removeFavourite(String favId)async{
    await firestore.collection('favourites').doc(favId).delete();


  }
}
