// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/domain/utils/razorpay/razorpay_helper.dart';
import 'package:urbandrive/presentation/booking_screen/pages/booking_confirm_loading.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/dropoff_address_tile.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/dropoff_time_card.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/pickup_address_tile.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/pickup_date_card.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/price_confirm_card.dart';

import 'package:urbandrive/presentation/main_page/pages/main_page.dart';

class BookingConfirmScreen extends StatefulWidget {
  BookingConfirmScreen({super.key, required this.bookingModel});

  BookingModel? bookingModel;

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

  Razorpay? razorpPay;

  BookingScreenHelper bookingdata = BookingScreenHelper();

  @override
  void initState() {
    razorpPay = Razorpay();
    razorpPay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpPay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpPay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    carmodelId = widget.bookingModel!.CarmodelId;
    pickedHours = widget.bookingModel!.PickupTime!.substring(0, 2);
    pickedMinutes = widget.bookingModel!.PickupTime!.substring(3, 5);
    dropHours = widget.bookingModel!.DropOffTime!.substring(0, 2);
    dropMinutes = widget.bookingModel!.DropOffTime!.substring(3, 5);
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
              appBar: AppBar(
                leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    )),
                title: Text(
                  "Confirm details",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                shadowColor: Colors.blueGrey,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                backgroundColor: Colors.blue,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                carmodel[0].images[1],
                                fit: BoxFit.cover,
                              ),
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
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: "\n${carmodel[0].model}",
                                          style: TextStyle(
                                              color: Colors.black,
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
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: "\t${carmodel[0].transmit}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  )),
                                  Text(
                                    "Booking for ${widget.bookingModel!.BookingDays} day",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
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
                                PickupDateandTime(
                                    pickupDate: dateFormatter(
                                        widget.bookingModel!.PickupDate!),
                                    //  pickMonth:    DateFormat('MMMM').format(DateTime(0,widget.bookingModel!.PickupDate!)),
                                    pickMonth:detailMonthFormatter( widget.bookingModel!.PickupDate!),
                                    pickedHours: pickedHours,
                                    pickedMinutes: pickedMinutes),
                                DropoffDateandTime(
                                    dropOffDate: dateFormatter(
                                        widget.bookingModel!.DropOffDate!),
                                    dropMonth: detailMonthFormatter(
                                       widget.bookingModel!.DropOffDate!),
                                    dropHours: dropHours,
                                    dropMinutes: dropMinutes),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PickpAddressTile(widget: widget),
                          DropoffAddressTile(widget: widget)
                        ],
                      ),
                    ),
                    Column(
                      children: [],
                    ),
                    PriceConfirmCard(
                        carmodel: carmodel,
                        ConFee: ConFee,
                        taxAmount: taxAmount,
                        discount: discount,
                        totalamount: totalamount),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              bottomNavigationBar: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: Offset(1, 2))],
                    color: Colors.white,
                  ),
                  height: 70,
                  child: GestureDetector(
                    onTap: () => addPaymentDetails(totalamount),
                    child: Center(
                        child: Text(
                      "PAY NOW \t₹ ${bookingdata.amountFormatter(totalamount)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20),
                    )),
                  ),
                ),
              ));
        } else if (state is CarDataLoadingState) {
          return CardataLoadingScreen(
              widget: widget,
              pickupDate: pickupDate,
              pickMonth: pickMonth,
              pickedHours: pickedHours,
              pickedMinutes: pickedMinutes,
              dropOffDate: dropOffDate,
              dropMonth: dropMonth,
              dropHours: dropHours,
              dropMinutes: dropMinutes);
        }
        return Container();
      },
    );
  }

    DateTime dateFormatter(String date) {
    return DateTime.parse(date);
  }

  String detailMonthFormatter(String value) {
    final date = DateTime.parse(value);
    final  pickMonth = DateFormat('MMMM').format(DateTime(0, date.month));
    return pickMonth;
  }

  addPaymentDetails(int amount) async {
    final razorKey = "rzp_test_M3Qr6Ay0H4LabB";
    bookingId = await firestore.collection('bookings').doc().id;

    String modelDetails = "${carmodel[0].brand!}\t${carmodel[0].model}";

    var options = {
      'key': razorKey,
      'amount': amount,
      'name': 'Urban Drive',
      "booking_id": bookingId,
      'description': modelDetails,
      'prefill': {'contact': '987654321', 'email': 'admin@urbandrive.com'}
    };

    addBooking(carmodel, options, bookingId!);
  }

  handlePaymentErrorResponse(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed",
    );
    context.read<CarBookingBloc>().add(CarBookingLoadedEvent(
        updateStatus: "Incomplete", bookingId: bookingId!));

    Map<String, dynamic> updateStatus = {"payment-status": "Cancelled"};

    firestore.collection('bookings').doc(bookingId).update(updateStatus);
  }

  handleExternalWalletSelected(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL WALLET IS : ${response.walletName}",
    );
    context.read<CarBookingBloc>().add(CarBookingLoadedEvent(
        updateStatus: "Successful", bookingId: bookingId!));
  }

  handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
      msg: "Payment Successful",
    );
    context.read<CarBookingBloc>().add(CarBookingLoadedEvent(
        updateStatus: "Incomplete", bookingId: bookingId!));
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

      final usermodelData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.bookingModel!.userId)
          .get();

      final carmodelCollection = await FirebaseFirestore.instance
          .collection('models')
          .doc(carmodelData[0].id)
          .get();

      Map<String, dynamic> modeldata = carmodelCollection.data() ?? {};
      Map<String, dynamic> userdata = usermodelData.data() ?? {};

      Map<String, dynamic> bookingdata = {
        "userdata": userdata,
        "booking-id": bookId,
        "carmodel": modeldata,
        "pickup-address": widget.bookingModel!.PickupAddress,
        "dropoff-location": widget.bookingModel!.DropoffAddress,
        "pickup-date": widget.bookingModel!.PickupDate,
        "dropoff-date": widget.bookingModel!.DropOffDate,
        "pick-up time": widget.bookingModel!.PickupTime,
        "drop-off time": widget.bookingModel!.DropOffTime,
        "booking-days": widget.bookingModel!.BookingDays,
        "agreement-tick": widget.bookingModel!.agrchcked,
        "toal-pay": totalPay,
        "payment-status": widget.bookingModel!.PaymentStatus,
      };

      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookId)
          .set(bookingdata)
          .then((value) => razorpPay?.open(options));
      bookingId = bookId;
      bookingData = bookingdata;
    } catch (e) {
      print("erroris ${e.toString()}");
    }
  }
}
