import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/domain/booking_model.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/domain/razorpay_options.dart';

class BookingConfirmScreen extends StatelessWidget {
  BookingConfirmScreen({super.key, required this.bookedData});

  BookingModel? bookedData;

  DateTime? pickupDate;
  String? pickMonth;
  String? pickedHours;
  String? pickedMinutes;
  DateTime? dropOffDate;
  String? dropMonth;
  String? dropHours;
  String? dropMinutes;
  String? carmodelId;

  List<CarModels> carmodel = [];
  String? bookingId;
  RazorpayPayment razorpayRepo = RazorpayPayment();

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    carmodelId = bookedData!.CarmodelId;

    var amtformat = NumberFormat("###,###.00#", "en_US");
    pickupDate = DateTime.parse(bookedData!.PickupDate!);
    pickMonth = DateFormat('MMMM').format(DateTime(0, pickupDate!.month));
    pickedHours = bookedData!.PickupTime!.substring(0, 2);
    pickedMinutes = bookedData!.PickupTime!.substring(3, 5);

    dropOffDate = DateTime.parse(bookedData!.DropOffDate!);
    dropMonth = DateFormat('MMMM').format(DateTime(0, dropOffDate!.month));
    dropHours = bookedData!.DropOffTime!.substring(0, 2);
    dropMinutes = bookedData!.DropOffTime!.substring(3, 5);
    context
        .read<CarBookingBloc>()
        .add(CardDataLoadedEvent(modelId: carmodelId));

    return BlocBuilder<CarBookingBloc, CarBookingState>(
      builder: (context, state) {
        if (state is CarDataLoadedState) {
          carmodel = state.carModel;
          int price = int.parse(carmodel[0].price!);
          int deposit = int.parse(carmodel[0].deposit!);
          int ConFee = 250;

          int taxAmount = (int.parse(carmodel[0].price!) * 18 / 100).round();

          int discount = (int.parse(carmodel[0].price!) * 25 / 100).round();

          int totalamount = (price + deposit + ConFee) - discount;
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
                              child: Image.network(
                                carmodel[0].images[1],
                                fit: BoxFit.cover,
                              ),
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "${carmodel[0].brand}",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: "\n${carmodel[0].model}",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  )),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "${carmodel[0].category}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: "\t${carmodel[0].transmit}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  )),
                                  Text(
                                    "Booking for ${bookedData!.BookingDays} day",
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              TextSpan(
                                                  text: "\n${pickMonth}",
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
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  height: 80,
                                  child: Text(
                                      maxLines: 5,
                                      "${bookedData!.PickupAddress}")),
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
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  height: 80,
                                  child: Text(
                                      maxLines: 5,
                                      "${bookedData!.DropoffAddress}")),
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
                                    border: Border.all(
                                        color: Colors.white, width: 4),
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
                                      trailing: Text("${carmodel[0].price}",
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
                                      trailing: Text("${carmodel[0].deposit}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: const Color.fromARGB(
                                                  255, 106, 106, 106),
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Convenience  Fee",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: const Color.fromARGB(
                                                255, 106, 106, 106),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      trailing: Text("${ConFee}",
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
                                      trailing: Text("${taxAmount}",
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
                                      trailing: Text("-${discount}",
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
                                    border: Border.all(
                                        color: Colors.white, width: 4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  title: Text("Total"),
                                  trailing: Text("₹ ${totalamount}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 160, 160, 160),
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BottomAppBar(
                  color: Colors.blue,
                  child: GestureDetector(
                    onTap: () async {
                      final razorKey = " 'rzp_test_M3Qr6Ay0H4LabB'";
                      bookingId =
                          await firestore.collection('bookings').doc().id;
                      // addbooking(carmodel, context);
                      String modelDetails =
                          "${carmodel[0].brand!}\t${carmodel[0].model}";
                      // razorpayRepo.paymentDetails(totalamount.toString(), modelDetails, bookingId);

                      Razorpay razorPay = Razorpay();

                      var options = {
                        'key': razorKey,
                        'amount': totalamount,
                        'name': 'Urban Drive',
                        "order_id": bookingId,
                        'description': modelDetails,
                        'prefill': {
                          'contact': '987654321',
                          'email': 'admin@urbandrive.com'
                        }
                      };

                 razorPay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccessResponse);
                  razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWalletSelected);
                  razorPay.open(options);
                    },
                    child: Center(
                        child: Text(
                      "PAY NOW \t₹ ${amtformat.format(totalamount)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    )),
                  ),
                ),
              ));
        } else if (state is CarDataLoadingState) {
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
                                  "Booking for ${bookedData!.BookingDays} day",
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
                                    "${bookedData!.PickupAddress}")),
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
                                    "${bookedData!.DropoffAddress}")),
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
        return Container();
      },
    );
  }


  addbooking(List<CarModels> carmodelData, context) async {
    String totalPay = (int.parse(carmodelData[0].deposit!) +
            int.parse(carmodelData[0].price!))
        .toString();

    Map<String, dynamic> bookingdata = {
      "uid": bookedData!.userId,
      "booking-id": bookingId,
      "carmodel-id": carmodelData[0].id,
      "pickup-address": bookedData!.PickupAddress,
      "dropoff-location": bookedData!.DropoffAddress,
      "pickup-date": bookedData!.PickupDate,
      "dropoff-date": bookedData!.DropOffDate,
      "pick-up time": bookedData!.PickupTime,
      "drop-off time": bookedData!.DropOffTime,
      "booking-days": bookedData!.BookingDays,
      "agreement-tick": bookedData!.agrchcked,
      "toal-pay": totalPay,
      "payment-status": bookedData!.PaymentStatus,
    };

    await firestore.collection('bookings').doc(bookingId).set(bookingdata);
    // .then((value) => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => BookingConfirmScreen(
    //         userId: widget.userId,
    //       ),
    //     )));
  }

   void handlePaymentErrorResponse(PaymentFailureResponse response, context) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.data.toString());
    void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  }


}

// Future<List<CarModels>> getCarModelData(String carmodelId) async {
//     final collection = await FirebaseFirestore.instance
//         .collection('models')
//         .where(carmodelId)
//         .get();

//     collection.docs.forEach((element) {
//       final data = element.data();

//       final cardetails = CarModels(
//           id: data['id'],
//           category: data['category'],
//           brand: data['brand'],
//           model: data['model'],
//           transmit: data['transmit'],
//           fuel: data['fuel'],
//           baggage: data['baggage'],
//           price: data['price'],
//           seats: data['seats'],
//           deposit: data['deposit'],
//           freekms: data['freekms'],
//           extrakms: data['extrakms'],
//           images: data['images']);

//        carmodel.add(cardetails);
//     });
//        return carmodel;
//   }

