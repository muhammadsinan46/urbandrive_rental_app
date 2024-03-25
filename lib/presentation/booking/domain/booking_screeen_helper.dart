import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:urbandrive/domain/car_model.dart';

class BookingScreenHelper{


    DateTime? startdate;

  List<CarModels> carmodelData = [];

  List<Widget> carousalitems = [];
  String? currentAddress;
  var amtformat = NumberFormat("###,###.00#", "en_US");

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




      
}