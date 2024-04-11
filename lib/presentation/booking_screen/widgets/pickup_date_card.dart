

import 'package:flutter/material.dart';

class PickupDateandTime extends StatelessWidget {
  const PickupDateandTime({
    super.key,
    required this.pickupDate,
     required this.pickMonth,
    required this.pickedHours,
    required this.pickedMinutes,
  });

  final DateTime? pickupDate;
   final String? pickMonth;
  final String? pickedHours;
  final String? pickedMinutes;

  @override
  Widget build(BuildContext context) {
    print(pickupDate!.day);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pick-up Date & Time",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        Card(
          child: Container(
            width: 160,
            height: 120,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10),
                color: Colors.blue),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "${pickupDate!.day}",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white)),
                  TextSpan(
                      text: "\n${pickupDate!.month}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w300,
                          color: Colors.white)),
                  TextSpan(
                      text: "\n${pickupDate!.year}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w300,
                          color: Colors.white)),
                ])),
                VerticalDivider(
                  width: 20,
                  indent: 15,
                  endIndent: 15,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "${pickedHours}",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white)),
                  TextSpan(
                      text: "\n${pickedMinutes}",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight:
                              FontWeight.w500,
                          color: Colors.white)),
                ])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
