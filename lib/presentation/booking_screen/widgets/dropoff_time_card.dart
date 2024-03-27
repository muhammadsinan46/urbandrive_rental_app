


import 'package:flutter/material.dart';

class DropoffDateandTime extends StatelessWidget {
  const DropoffDateandTime({
    super.key,
    required this.dropOffDate,
    required this.dropMonth,
    required this.dropHours,
    required this.dropMinutes,
  });

  final DateTime? dropOffDate;
  final String? dropMonth;
  final String? dropHours;
  final String? dropMinutes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Drop-off Date & Time",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
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
                      text: "${dropOffDate!.day}",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white)),
                  TextSpan(
                      text: "\n${dropMonth}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w300,
                          color: Colors.white)),
                  TextSpan(
                      text:
                          "\n${dropOffDate!.year}",
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
                      text: "${dropHours}",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.white)),
                  TextSpan(
                      text: "\n${dropMinutes}",
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

