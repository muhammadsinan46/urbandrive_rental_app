import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbandrive/domain/booking_model.dart';

class BookingRepo {
  List<BookingModel> bookingDataList = [];

  Future<List<BookingModel>> getBookingData(String userId) async {

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
            PickupDate: data['pickup-date'],
            PickupTime: data['pick-up time'],
            PickupAddress: data['pickup-address'],
            DropOffDate: data['dropoff-date'],
            DropOffTime: data['drop-off time'],
            DropoffAddress: data['dropoff-location'],
            PaymentAmount: data['toal-pay'].toString(),
            PaymentStatus: data['payment-status'],
            carmodel: data['carmodel']
            );
   

         

        bookingDataList.add(bookingdetails);


      });
              print("booking datalist is ${bookingDataList}");
      return bookingDataList;
    } on FirebaseException catch (e) {
      print(e.message);
      return bookingDataList;
    }
  }
}
