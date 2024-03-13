import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/domain/booking_model.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/domain/razorpay_options.dart';
import 'package:urbandrive/presentation/pages/home_screen.dart';
import 'package:urbandrive/presentation/pages/main_page.dart';

class BookingConfirmScreen extends StatefulWidget {
  BookingConfirmScreen({super.key, required this.bookedData});

  BookingModel? bookedData;

  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
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
  Map<String, dynamic> bookingData = {};

  RazorpayPayment razorpayRepo = RazorpayPayment();

  final firestore = FirebaseFirestore.instance;

  Razorpay? razorpay;

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    super.initState();
  }

  handlePaymentErrorResponse(PaymentFailureResponse response) {
    print("response of failure is $response");
    Fluttertoast.showToast(
      msg: "Payment Failed",
    );
    context.read<CarBookingBloc>().add(
        CarBookingLoadedEvent(updateStatus: "Incomplete", bookingId: bookingId!));

    Map<String, dynamic> updateStatus = {"payment-status": "Cancelled"};

    firestore.collection('bookings').doc(bookingId).update(updateStatus);
  }

  handleExternalWalletSelected(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL WALLET IS : ${response.walletName}",
    );
    context.read<CarBookingBloc>().add(
        CarBookingLoadedEvent(updateStatus: "Successful", bookingId: bookingId!));
  }

  handlePaymentSuccessResponse(PaymentSuccessResponse response)async {
    Fluttertoast.showToast(
      msg: "Payment Successful",
    );
    context.read<CarBookingBloc>().add(
        CarBookingLoadedEvent(updateStatus: "Incomplete", bookingId: bookingId!));
    Map<String, dynamic> updateStatus = {"payment-status": "Successful"};

    await firestore
        .collection('bookings')
        .doc(bookingId)
        .update(updateStatus)
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
            (route) => false));
  }

  addBooking(List<CarModels> carmodelData, Map<String, dynamic> options,
      String bookId) async {
    try {
      String totalPay = (int.parse(carmodelData[0].deposit!) +
              int.parse(carmodelData[0].price!))
          .toString();

      Map<String, dynamic> bookingdata = {
        "uid": widget.bookedData!.userId,
        "booking-id": bookId,
        "carmodel-id": carmodelData[0].id,
        "pickup-address": widget.bookedData!.PickupAddress,
        "dropoff-location": widget.bookedData!.DropoffAddress,
        "pickup-date": widget.bookedData!.PickupDate,
        "dropoff-date": widget.bookedData!.DropOffDate,
        "pick-up time": widget.bookedData!.PickupTime,
        "drop-off time": widget.bookedData!.DropOffTime,
        "booking-days": widget.bookedData!.BookingDays,
        "agreement-tick": widget.bookedData!.agrchcked,
        "toal-pay": totalPay,
        "payment-status": widget.bookedData!.PaymentStatus,
      };

      await FirebaseFirestore.instance.collection('bookings').doc(bookId).set(bookingdata).then((value) => razorpay?.open(options));
      bookingId = bookId;
      bookingData = bookingdata;


    } catch (e) {
      print("erroris ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    carmodelId = widget.bookedData!.CarmodelId;

    var amtformat = NumberFormat("###,###.00#", "en_US");
    pickupDate = DateTime.parse(widget.bookedData!.PickupDate!);
    pickMonth = DateFormat('MMMM').format(DateTime(0, pickupDate!.month));
    pickedHours = widget.bookedData!.PickupTime!.substring(0, 2);
    pickedMinutes = widget.bookedData!.PickupTime!.substring(3, 5);

    dropOffDate = DateTime.parse(widget.bookedData!.DropOffDate!);
    dropMonth = DateFormat('MMMM').format(DateTime(0, dropOffDate!.month));
    dropHours = widget.bookedData!.DropOffTime!.substring(0, 2);
    dropMinutes = widget.bookedData!.DropOffTime!.substring(3, 5);
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
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
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
                      final razorKey = "rzp_test_M3Qr6Ay0H4LabB";
                      bookingId =
                          await firestore.collection('bookings').doc().id;

                      String modelDetails =
                          "${carmodel[0].brand!}\t${carmodel[0].model}";

                      var options = {
                        'key': razorKey,
                        'amount': totalamount,
                        'name': 'Urban Drive',
                        "booking_id": bookingId,
                        'description': modelDetails,
                        'prefill': {
                          'contact': '987654321',
                          'email': 'admin@urbandrive.com'
                        }
                      };

                      addBooking(carmodel, options, bookingId!);
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
        return Container();
      },
    );
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

