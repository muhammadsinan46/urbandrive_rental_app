


import 'package:flutter/material.dart';
import 'package:urbandrive/presentation/booking_screen/pages/booking_confirm.dart';

class PickpAddressTile extends StatelessWidget {
  const PickpAddressTile({
    super.key,
    required this.widget,
  });

  final BookingConfirmScreen widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Pick-up address",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Card(
        child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(
                      255, 227, 227, 227)),
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(
                  255, 255, 255, 255),
            ),
            height: 80,
            child: Text(
                maxLines: 5,
                "${widget.bookingModel!.PickupAddress}", style: TextStyle(fontSize: 12),)),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: TextButton(
          child: Text(
            "Change",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}