
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';

class ShowDropoffDate extends StatelessWidget {
  ShowDropoffDate(
      {super.key,
      required this.enddate,
      required this.endweek,
      required this.endMonth,
      required this.bookingDataList,
      required this.idx,
      required this.isEdit});

  final DateTime enddate;
  final String endweek;
  final String endMonth;
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
            textHeightBehavior: TextHeightBehavior(
                leadingDistribution: TextLeadingDistribution.even),
            textAlign: TextAlign.center,
            text: TextSpan(style: TextStyle(color: Colors.blue), children: [
              TextSpan(
                  text: "Drop -Off\n",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              TextSpan(
                  text: isEdit == false
                      ? "${enddate.day}"
                      : bookingDataList![idx!].DropOffDate,
                  style: TextStyle(fontSize: 60)),
              TextSpan(
                  style: TextStyle(
                    wordSpacing: 10,
                  ),
                  children: [
                    TextSpan(text: "\n${endweek}"),
                    TextSpan(text: "|"),
                    TextSpan(
                        text: isEdit == false
                            ? " ${endMonth} "
                            : " ${bookingDataList![idx!].dropMonth}"),

                    // TextSpan(
                    //     text: "\n\n10:00",
                    //     style: TextStyle(
                    //         fontSize: 20,
                    //         wordSpacing: 12)),
                  ]),
            ])),
      ),
    );
  }
}