
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';

class UpdateBookingButton extends StatelessWidget {
  const UpdateBookingButton({
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
              color:  Colors.green,
              borderRadius: BorderRadius.circular(10)),
          height: 70,
          width: 160,
          child: Center(
              child: Text(
            "Update",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18),
          )),
        );
  }
}
