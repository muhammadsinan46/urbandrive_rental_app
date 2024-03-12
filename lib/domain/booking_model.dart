class BookingModel {
  String ? userId;
  String? CarmodelId;
 // String? BookingId;
  String? BookingDays;
  String? PickupTime;
  String? PickupDate;
  String? PickupAddress;
  String? DropOffTime;
  String? DropOffDate;
  String? DropoffAddress;
  String? PaymentAmount;
  String? PaymentStatus;
  bool? agrchcked;

  

  BookingModel({
    required this.userId,
    required this.CarmodelId,
   // required this.BookingId,
    required this.BookingDays,
    required this.PickupDate,
    required this.PickupTime,
    required this.PickupAddress,
    required this.DropOffDate,
    required this.DropOffTime,
    required this.DropoffAddress,
    required this.PaymentAmount,
    required this.PaymentStatus,
    required this.agrchcked,

  });
}
