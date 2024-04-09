
import 'package:flutter/material.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';

class ShowPickupDate extends StatelessWidget {
  ShowPickupDate(
      {super.key,
      required this.startdate,
      required this.startweek,
      required this.startMonth,
      required this.bookingDataList,
      required this.idx,
      required this.isEdit});

  final DateTime startdate;
  final String startweek;
  final String startMonth;
  final List<BookingModel>? bookingDataList;

  int? idx;

  bool? isEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 150,
      child: Center(
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(style: TextStyle(color: Colors.blue), children: [
              TextSpan(
                  text: "Pick-Up",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              TextSpan(
                  text: isEdit == false
                      ? "\n${startdate.day}"
                      : "\n${bookingDataList![idx!].PickupDate}",
                  style: TextStyle(fontSize: 60)),
              TextSpan(style: TextStyle(wordSpacing: 10), children: [
                TextSpan(text: "\n ${startweek} "),
                TextSpan(text: "|"),
                TextSpan(
                    text: isEdit == false
                        ? " ${startMonth}"
                        : " ${bookingDataList![idx!].pickMonth}"),
                //  TextSpan(
                //   text: "\n\n10:00",
                //   style: TextStyle(
                //       fontSize: 20,
                //       wordSpacing: 12)),
              ]),
            ])),
      ),
    );
  }
}