import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbandrive/domain/booking_model.dart';
import 'package:urbandrive/domain/brand_model.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/domain/category_model.dart';

class CardataRepo {
  Future<List<BrandModel>> getBranddata() async {
    List<BrandModel> brandlist = [];

    try {
      final brandcollection =
          await FirebaseFirestore.instance.collection('brands').get();

      brandcollection.docs.forEach((element) {
        final data = element.data();

        final brandData = BrandModel(
            name: data['name'],
            description: data['description'],
            logo: data['logo']);

        brandlist.add(brandData);
      });
      return brandlist;
    } on FirebaseException catch (e) {
      print("unable to get brand data ${e.message}");

      return brandlist;
    }
  }

  Future<List<CategoryModel>> getCategoryData()async{
    List<CategoryModel> categorylist =[];

    try{
      final categoryCollection = await FirebaseFirestore.instance.collection('category').get();

      categoryCollection.docs.forEach((element) { 

        final data = element.data();
        final categoryData =CategoryModel(name: data['name'], description:  data['description'], image: data['image']);

        categorylist.add(categoryData);
      });
      return categorylist;
    }on FirebaseException catch(e){

      print("error occured ${e.message}");
    return categorylist;
    }

  }
    Future<List<CarModels>> getCarModels() async {
    final List<CarModels> carmodelslist = [];

    try {
      final carDataModelCollection =
          await FirebaseFirestore.instance.collection('models').get();

      carDataModelCollection.docs.forEach((element) {
        final data = element.data();

        final carmodel = CarModels(
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

        carmodelslist.add(carmodel);
        print(carmodelslist);
      });

      return carmodelslist;
    } on FirebaseException catch (e) {
      print("error is ${e.message}");
      return carmodelslist;
    }
  }

  Future<List<CarModels>> getSpecificModel(String id)async{

    List<CarModels> carmodelData =[];

    try{

      final cardata = await FirebaseFirestore.instance.collection('models').where('id',isEqualTo: id).get();

      cardata.docs.forEach((element) {
      final   data = element.data();

      final cardata = CarModels(
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

            carmodelData.add(cardata);
       });

       return carmodelData;

      
    }on FirebaseException catch(e){

      print(e.message);

      return carmodelData;
    }

  }


  Future<List<BookingModel>> getBookingData(String userId) async {
        List<BookingModel> bookingDataList = [];
          print("booking ");
    try {
      final bookingCollection = await FirebaseFirestore.instance
          .collection('bookings')
          .where(userId)
          .get();

      bookingCollection.docs.forEach((element) {
        final data = element.data();

        final bookingdetails = BookingModel(
          agrchcked: data['checked'],
            userId: data['uid'],
            CarmodelId: data['carmodel-id'],
           BookingId: data['booking-id'],
            BookingDays: data['booking-days'],
            PickupDate: data['picup-date'],
            PickupTime: data['pick-up time'],
            PickupAddress: data['pickup-address'],
            DropOffDate: data['dropoff-date'],
            DropOffTime: data['drop-off time'],
            DropoffAddress: data['dropoff-location'],
            PaymentAmount: data['toal-pay'].toString(),
            PaymentStatus: data['payment-status'],
            carmodel: data['carmodel'],
            userdata:data['userdata']
            );
   

            print("booking confirmed data is $bookingdetails");

        bookingDataList.add(bookingdetails);
      });

      return bookingDataList;
    } on FirebaseException catch (e) {
      print(e.message);
      return bookingDataList;
    }
  }
}
