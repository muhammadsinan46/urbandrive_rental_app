import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';
import 'package:urbandrive/infrastructure/brand_model/brand_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/infrastructure/category_model/category_model.dart';

class CardataRepo {
  final categoryCollection = FirebaseFirestore.instance.collection('category');
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

  Future<List<CategoryModel>> getCategoryData() async {
    List<CategoryModel> categorylist = [];

    try {
      final categorydata = await categoryCollection.get();

      categorydata.docs.forEach((element) {
        final data = element.data();
        final categoryData = CategoryModel(
            name: data['name'],
            description: data['description'],
            image: data['image']);

        categorylist.add(categoryData);
      });
      return categorylist;
    } on FirebaseException catch (e) {
      print("error occured ${e.message}");
      return categorylist;
    }
  }

  Future<List<CarModels>> getSpecificCategoryList(String catename) async {



    List<CarModels> specificCateList = [];

    try {
      final CateCollection = await FirebaseFirestore.instance
          .collection('models')
          .where('category', isEqualTo: catename)
          .get();

      CateCollection.docs.forEach((element) {
        final data = element.data();

  

        final carModels = CarModels(
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
          images: data['carImages'],
        );
        specificCateList.add(carModels);
      });

      return specificCateList;
    } on FirebaseException catch (e) {
      print(e.message);
      return specificCateList;
    }
  }

  // getFavList()async{

  //   List<CarModels> favList =[];

  //   final

  // }

  Future<List<CarModels>> getCarModels() async {
    final List<CarModels> carmodelslist = [];


    try {
      final carDataModelCollection =
          await FirebaseFirestore.instance.collection('models').get();

      carDataModelCollection.docs.forEach((element)async {
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
          images: data['carImages'],
        //  rating:  rating

        );

        carmodelslist.add(carmodel);
      });
                print("rating is ${carmodelslist[1].baggage}");
      return carmodelslist;
    } on FirebaseException catch (e) {
      print("error is ${e.message}");
      return carmodelslist;
    }
  }

  Future<List<CarModels>> getSpecificModel(String id) async {
    List<CarModels> carmodelData = [];

    try {
      final cardata = await FirebaseFirestore.instance
          .collection('models')
          .where('id', isEqualTo: id)
          .get();
                final feedColl = await FirebaseFirestore.instance.collection('feedback').where('carmodel-id', isEqualTo: id, ).get();
      double  ratingSum =0;
      feedColl.docs.forEach((element) { 
           final dat= element.get('rating');
      ratingSum += dat;
      });
      double rating = ratingSum/feedColl.size;
     
      cardata.docs.forEach((element) {
        final data = element.data();

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
            images: data['carImages'],
            rating: rating
            
            );

        carmodelData.add(cardata);
      });

      return carmodelData;
    } on FirebaseException catch (e) {
      print(e.message);

      return carmodelData;
    }
  }

  Future<List<BookingModel>> getUpcomingBookingData(String userId) async {
    List<BookingModel> bookingDataList = [];

    try {
      DateTime pickupDate;
      DateTime currentDate = DateTime.now();

      final bookingCollection = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userdata.uid', isEqualTo: userId)
          .orderBy('pickup-date')
          .get();

      bookingCollection.docs.forEach((element) {
        final bookingdate = element['pickup-date'];
        pickupDate = DateTime.parse(bookingdate);

        if (pickupDate.isAfter(currentDate)) {
          final data = element.data();

          DateTime pickupDate = DateTime.parse(data['pickup-date']);
          DateTime dropOffDate = DateTime.parse(data['dropoff-date']);
          String pickMonth =
              DateFormat('MMM').format(DateTime(0, pickupDate.month));
          String dropMonth =
              DateFormat('MMM').format(DateTime(0, dropOffDate.month));

          final bookingdetails = BookingModel(
              agrchcked: data['agreement-tick'],
              userId: data['userdata']['uid'],
              CarmodelId: data['carmodel']['id'],
              BookingId: data['booking-id'],
              BookingDays: data['booking-days'],
              PickupDate: pickupDate.day.toString(),
              PickupTime: data['pick-up time'],
              PickupAddress: data['pickup-address'],
              DropOffDate: dropOffDate.day.toString(),
              DropOffTime: data['drop-off time'],
              DropoffAddress: data['dropoff-location'],
              PaymentAmount: data['toal-pay'].toString(),
              PaymentStatus: data['payment-status'],
              carmodel: data['carmodel'],
              userdata: data['userdata'],
              pickMonth: pickMonth,
              dropMonth: dropMonth);

          bookingDataList.add(bookingdetails);
        }
      });

      return bookingDataList;
    } on FirebaseException catch (e) {
      print(e.message);
      return bookingDataList;
    }
  }

  Future<List<BookingModel>> getBookingHistory(String userId) async {
    List<BookingModel> bookingHistoryList = [];
    try {
      DateTime pickupDate;
      DateTime currentDate = DateTime.now();

      final collection = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userdata.uid', isEqualTo: userId)
          .orderBy('pickup-date')
          .get();

      collection.docs.forEach((doc) {
        final bookingdate = doc['pickup-date'];
        pickupDate = DateTime.parse(bookingdate);

        if (pickupDate.isBefore(currentDate)) {
          final data = doc.data();

          DateTime pickupDate = DateTime.parse(data['pickup-date']);
          DateTime dropOffDate = DateTime.parse(data['dropoff-date']);
          String pickMonth =
              DateFormat('MMM').format(DateTime(0, pickupDate.month));
          String dropMonth =
              DateFormat('MMM').format(DateTime(0, dropOffDate.month));

          final bookingHistory = BookingModel(
              agrchcked: data['agreement-tick'],
              userId: data['userdata']['uid'],
              CarmodelId: data['carmodel']['id'],
              BookingId: data['booking-id'],
              BookingDays: data['booking-days'],
              PickupDate: pickupDate.day.toString(),
              PickupTime: data['pick-up time'],
              PickupAddress: data['pickup-address'],
              DropOffDate: dropOffDate.day.toString(),
              DropOffTime: data['drop-off time'],
              DropoffAddress: data['dropoff-location'],
              PaymentAmount: data['toal-pay'].toString(),
              PaymentStatus: data['payment-status'],
              carmodel: data['carmodel'],
              userdata: data['userdata'],
              pickMonth: pickMonth,
              dropMonth: dropMonth);

          bookingHistoryList.add(bookingHistory);
        }
      });
      return bookingHistoryList;
    } on FirebaseException catch (e) {
      print("error of booking history is ${e.message}");

      return bookingHistoryList;
    }
  }
}
