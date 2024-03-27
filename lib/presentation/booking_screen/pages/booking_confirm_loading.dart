


import 'package:flutter/material.dart';
import 'package:urbandrive/presentation/booking_screen/pages/booking_confirm.dart';

class CardataLoadingScreen extends StatelessWidget {
  const CardataLoadingScreen({
    super.key,
    required this.widget,
    required this.pickupDate,
    required this.pickMonth,
    required this.pickedHours,
    required this.pickedMinutes,
    required this.dropOffDate,
    required this.dropMonth,
    required this.dropHours,
    required this.dropMinutes,
  });

  final BookingConfirmScreen widget;
  final DateTime? pickupDate;
  final String? pickMonth;
  final String? pickedHours;
  final String? pickedMinutes;
  final DateTime? dropOffDate;
  final String? dropMonth;
  final String? dropHours;
  final String? dropMinutes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue),
                height: 160,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      height: 150,
                      width: 180,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      //  color: Colors.yellow,
                      height: 150,
                      width: MediaQuery.sizeOf(context).width - 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "{carmodel[0].brand}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\nModel",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400)),
                            ],
                          )),
                          RichText(
                              text: TextSpan(
                            style: TextStyle(wordSpacing: 5),
                            children: [
                              TextSpan(
                                  text: "Type",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: "Transmit",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                            ],
                          )),
                          Text(
                            "Booking for ${widget.bookedData!.BookingDays} day",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
    
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 239, 247, 249),
              ),
              // height: 160,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
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
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      TextSpan(
                                          text: "\n${pickMonth}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white)),
                                      TextSpan(
                                          text: "\n${pickupDate!.year}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
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
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      TextSpan(
                                          text: "\n${pickedMinutes}",
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ])),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
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
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      TextSpan(
                                          text: "\n${dropMonth}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white)),
                                      TextSpan(
                                          text: "\n${dropOffDate!.year}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
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
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      TextSpan(
                                          text: "\n${dropMinutes}",
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ])),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
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
                            color:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          height: 80,
                          child: Text(
                              maxLines: 5,
                              "${widget.bookedData!.PickupAddress}")),
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
                  ),
                  ListTile(
                    title: Text(
                      "Drop-off address",
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
                            color:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          height: 80,
                          child: Text(
                              maxLines: 5,
                              "${widget.bookedData!.DropoffAddress}")),
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
                  )
                ],
              ),
            ),
            Column(
              children: [],
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: Color.fromARGB(255, 237, 245, 249),
                //  color: Colors.amberAccent,
                width: MediaQuery.sizeOf(context).width,
    
                child: Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white, width: 4),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Text(
                              "Price Summary",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400),
                            ),
                            ListTile(
                              title: Text(
                                "price Amount",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Text("${0}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 106, 106, 106),
                                      fontWeight: FontWeight.w400)),
                            ),
                            ListTile(
                              title: Text(
                                "Deposit Amount",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Text("25000",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 106, 106, 106),
                                      fontWeight: FontWeight.w400)),
                            ),
                            ListTile(
                              title: Text(
                                "Price Amount",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Text("25000",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 106, 106, 106),
                                      fontWeight: FontWeight.w400)),
                            ),
                            ListTile(
                              title: Text(
                                "Tax(GST)",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Text("",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 106, 106, 106),
                                      fontWeight: FontWeight.w400)),
                            ),
                            ListTile(
                              title: Text(
                                "discount applied",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: const Color.fromARGB(
                                        255, 106, 106, 106),
                                    fontWeight: FontWeight.w400),
                              ),
                              leading: Image.asset(
                                'lib/assets/images/discount.png',
                                height: 20,
                                width: 20,
                              ),
                              trailing: Text("-250",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(
                                          255, 160, 160, 160),
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                      ),
    
                      //  Divider(),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white, width: 4),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: Text("Total"),
                          trailing: Text("400",
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Color.fromARGB(255, 160, 160, 160),
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
