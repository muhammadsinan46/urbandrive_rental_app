import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbandrive/domain/car_model.dart';

class SearchRepo {

  Future <List<CarModels>> getallModels()async{

    List<CarModels> getAllModelsList =[];


    final modelCollection = await FirebaseFirestore.instance.collection('models').get();

    modelCollection.docs.forEach((element) {

      final data = element.data();

      final carData = CarModels(
          id: data['id'],
          category: data['category'],
          brand: data['brand'],
          model: data['model'],
          transmit: data['transmit'],
          fuel: data['fuel'],
          baggage: data['baggage'],
          price: data['price'],
          seats: data['seats'],
          deposit: data['deposit'],
          freekms: data['freekms'],
          extrakms: data['extrakms'],
          images: data['carImages']);

          getAllModelsList.add(carData);
    });


    return getAllModelsList ;
  }


  Future<List<CarModels>> getSerachCars(String searchValue) async {
    List<CarModels> searchCarList = [];
try{

    final searchCollection = await FirebaseFirestore.instance
        .collection('models')
        .where('brand', isEqualTo: searchValue).get();

    searchCollection.docs.forEach((element) {
      final data = element.data();

      
   
      final carDetails = CarModels(
          id: data['id'],
          category: data['category'],
          brand: data['brand'],
          model: data['model'],
          transmit: data['transmit'],
          fuel: data['fuel'],
          baggage: data['baggage'],
          price: data['price'],
          seats: data['seats'],
          deposit: data['deposit'],
          freekms: data['freekms'],
          extrakms: data['extrakms'],
          images: data['carImages']);

      searchCarList.add(carDetails);
    });

    return searchCarList;


}on FirebaseFirestore catch(e){

  print(e.toString());
      return searchCarList;

}
  }

  
  getFilterData(List<String >filterData)async{

    List<CarModels> allCarData =await getallModels() ;



    allCarData.where((element) => false);

  for(final filter in filterData){

    for(final data in allCarData){

      if(data.category!.contains(filter)){

        print("founded data is ${data.model}");
      }else if(data.brand!.contains(filter)){

           print("founded data is ${data.model}");
      }
    }


  }



  }



 Future< List<CarModels> > getCarStyleFilterData(List<String >filterData)async{

    List<CarModels> allCarData =await getallModels() ;

    List<CarModels> carStyleList =[];

    allCarData.where((element) => false);

  for(final filter in filterData){

    for(final data in allCarData){

      if(data.category!.contains(filter)){
          carStyleList.add(data);
      
      }
      else if(data.brand!.contains(filter)){

        carStyleList.add(data);
      }
    }


  }
  return carStyleList;


  }
}
