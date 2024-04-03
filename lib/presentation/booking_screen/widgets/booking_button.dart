

import 'package:flutter/material.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({
    super.key,
    required this.agrchcked,
    required this.bookingdata,
  });

  final bool agrchcked;
  final BookingScreenHelper bookingdata;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: agrchcked == false &&
                  bookingdata.pickuplocation.length == 0 &&
                  bookingdata.dropofflocation.length == 0
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