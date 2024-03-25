class BookingModel {
  String ? userId;
  String? CarmodelId;
   String? BookingId;
  String? BookingDays;
  String? PickupTime;
  String? PickupDate;
  String? PickupAddress;
  String? DropOffTime;
  String? DropOffDate;
  String? DropoffAddress;
  String? PaymentAmount;
  String? PaymentStatus;
  String? pickupDate;

  String? pickMonth;

  String? pickedHours;

  String? pickedMinutes;

  String? dropOffDate;

  String? dropMonth;

  String? dropHours;

  String? dropMinutes;
  bool? agrchcked;
  Map<String, dynamic>? carmodel;
  Map<String, dynamic>? userdata;

  

  BookingModel({
     this.userId,

    required this.CarmodelId,
   this.BookingId,
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
    this.carmodel,
    this.userdata,
    this.pickMonth,
    this.pickedHours,
    this.pickedMinutes,
    this.dropHours,
    this.dropMinutes,
    this.dropMonth

  });
}
