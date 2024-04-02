import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';

class SearchRepo {
  Future<List<CarModels>> getallModels() async {
    List<CarModels> getAllModelsList = [];

    final modelCollection =
        await FirebaseFirestore.instance.collection('models').get();

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

    return getAllModelsList;
  }

  Future<List<CarModels>> getSerachCars(String searchValue) async {
 String search = "${searchValue[0].toUpperCase()}${searchValue.substring(1).toLowerCase()}";

    List<CarModels> searchCarList = [];
    try {
      final searchCollection = await FirebaseFirestore.instance
          .collection('models')
          .where('brand', isEqualTo: search)
          .get();

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
    } on FirebaseFirestore catch (e) {
      print(e.toString());
      return searchCarList;
    }
  }

  getFilterData(List<String> filterData) async {
    List<CarModels> allCarData = await getallModels();

    allCarData.where((element) => false);

    for (final filter in filterData) {
      for (final data in allCarData) {
        if (data.category!.contains(filter)) {
          print("founded data is ${data.model}");
        } else if (data.brand!.contains(filter)) {
          print("founded data is ${data.model}");
        }
      }
    }
  }

  Future<List<CarModels>> getCarStyleFilterData(List<String> filterData) async {
    List<CarModels> allCarData = await getallModels();

    List<CarModels> carStyleList = [];

    allCarData.where((element) => false);

    for (final filter in filterData) {
      for (final data in allCarData) {
        if (data.category!.contains(filter)) {
          carStyleList.add(data);
        } else if (data.brand!.contains(filter)) {
          carStyleList.add(data);
        }
      }
    }
    return carStyleList;
  }

  Future<List<CarModels>> getPriceRangeFilter(List<int> priceRange) async {
    List<CarModels> allCarData = await getallModels();

    List<CarModels> priceRangeList = [];

    for (final data in allCarData) {
      int priceValue = int.parse(data.price!);

      if (priceRange[0] <= priceValue && priceRange[1] >= priceValue) {
        priceRangeList.add(data);
      }
    }

    return priceRangeList;
  }

  Future<List<CarModels>> getPriceSortFilter(String value) async {
    List<CarModels> allCarData = await getallModels();

    List<CarModels> carlowHighList =[];
    List<CarModels> carhighLowList =[];

    if (value == "Price Low to high") {
      carlowHighList = allCarData..sort((a, b) => lowHighPrices(a.price!, b.price!));
      carhighLowList.clear();
      return carlowHighList;
      
    } else if (value == "Price High to Low") {
     carhighLowList=  allCarData..sort((a, b) => lowHighPrices(b.price!, a.price!));
    carlowHighList.clear();
    return carhighLowList;
    }

    return allCarData;



  }

int lowHighPrices(String priceA, String priceB)  {
      int price1 = int.parse(priceA);
      int price2 = int.parse(priceB);

      return  price1.compareTo(price2);
    }

    int highLowPrices(String priceA, String priceB) {
      int price1 = int.parse(priceA);
      int price2 = int.parse(priceB);

      return price2.compareTo(price1);
    }


    
  
}
