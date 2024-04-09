

import 'package:flutter/material.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({
    super.key,
    required this.agrchcked,
    required this.bookingDataHelper,
  });

  final bool agrchcked;
  final BookingScreenHelper bookingDataHelper;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: agrchcked == false &&
                  bookingDataHelper.pickuplocation.length == 0 &&
                  bookingDataHelper.dropofflocation.length == 0
              ? Color.fromARGB(74, 255, 255, 255)
              : Colors.green,
          borderRadius: BorderRadius.circular(10)),
      height: 70,
      width: 160,
      child: Center(
          child: Text(
        "Continue",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18),
      )),
    );
  }
}