import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';

class BookingScreenHelper{
  




    DateTime? startdate;

  List<CarModels> carmodelData = [];

  List<Widget> carousalitems = [];
  String? currentAddress;
  

  String? picklocation;

  List<dynamic> pickuplocation = [];

  List<dynamic> dropofflocation = [];

  DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  Duration pickedTime = Duration(
      hours: int.parse(DateFormat('kk').format(DateTime.now())),
      minutes: int.parse(DateFormat('mm').format(DateTime.now())));

  Duration dropTime = Duration(
      hours: int.parse(DateFormat('kk').format(DateTime.now())),
      minutes: int.parse(DateFormat('mm').format(DateTime.now())));



DateTime dateFormatter(String date){
  return  DateTime.parse(date);

}
String  detailMonthFormatter(int month){

  String pickMonth = DateFormat('MMMM').format(DateTime(0,month));
  return pickMonth;
}


String startMonthFormatter() {
  String month = DateFormat('MMMM').format(selectedDate.start);
  return month;
}
String endMonthFormatter() {
  String month = DateFormat('MMMM').format(selectedDate.end);
  return month;
}

String startWeekFormatter() {
  String week = DateFormat('EEE').format(selectedDate.start);
  return week;
}
String endWeekFormatter() {
  String week = DateFormat('EEE').format(selectedDate.end);
  return week;
}


String amountFormatter(int amount){
  var amtformat = NumberFormat("###,###.00#", "en_US");
  return amtformat.format(amount);
}
      
}