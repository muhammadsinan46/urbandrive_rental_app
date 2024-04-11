// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:urbandrive/application/dropoff_location_bloc/dropoff_location_bloc.dart';
import 'package:urbandrive/application/pickup_location_bloc/location_bloc.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';
import 'package:urbandrive/presentation/booking_screen/pages/booking_confirm.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/booking_button.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/booking_screen_app_bar.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/cancellation_card.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/car_features_card.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/car_model_main_card.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/show_dropoff_date.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/show_pickup_date.dart';
import 'package:urbandrive/presentation/booking_screen/widgets/update_button.dart';
import 'package:urbandrive/presentation/location_screen/widgets/location_search.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_shimmer.dart';

class CarBookingScreen extends StatefulWidget {
  CarBookingScreen(
      {super.key,
      required this.carId,
      required this.userId,
      required this.locationStatus,
      this.bookingDataList,
      this.idx,
      required this.isEdit});
  final bool? locationStatus;

  final String carId;
  final String userId;

  final List<BookingModel>? bookingDataList;
  int? idx;

  bool? isEdit;

  @override
  State<CarBookingScreen> createState() => _CarBookingScreenState();
}

class _CarBookingScreenState extends State<CarBookingScreen> {
  BookingScreenHelper bookingDataHelper = BookingScreenHelper();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool agrchcked = false;
  String paymentStatus = "pending";
  bool? isDateEdit;

  @override
  void initState() {
    super.initState();
    isDateEdit = widget.isEdit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.sizeOf(context).width;

    context
        .read<CarBookingBloc>()
        .add(CardDataLoadedEvent(modelId: widget.carId));

    return Scaffold(
        body: BlocBuilder<CarBookingBloc, CarBookingState>(
          builder: (context, state) {
   
            if (state is CarDataLoadingState) {
              return ShimmerCarBookingScreen();
            } else if (state is CarDataLoadedState) {
              bookingDataHelper.carmodelData = state.carModel;

              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    BookingScreenAppBar(
                        widget: widget, bookingDataHelper: bookingDataHelper)
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CarModelMainCard(
                                bookingDataHelper: bookingDataHelper,
                                sWidth: sWidth),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 213, 213, 213))),
                          height: 140,
                          child: CarFeaturesCard(
                              sWidth: sWidth,
                              bookingDataHelper: bookingDataHelper),
                          width: MediaQuery.sizeOf(context).width,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 213, 213, 213))),
                          height: 80,
                          width: MediaQuery.sizeOf(context).width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 100,
                                child: Column(
                                  children: [
                                    Text("Deposit"),
                                    Text(
                                        "₹ ${bookingDataHelper.carmodelData[0].deposit}")
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                child: Column(
                                  children: [
                                    Text("Free Kms"),
                                    Text(
                                        "${bookingDataHelper.carmodelData[0].freekms!}/day")
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                child: Column(
                                  children: [
                                    Text("Extra Kms"),
                                    Text(
                                        "₹ ${bookingDataHelper.carmodelData[0].extrakms!}")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 213, 213, 213))),
                          height: 250,
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Pick-up address")),
                                    BlocBuilder<LocationBloc, LocationState>(
                                      builder: (context, state) {
                                        if (state is LocationInitialState) {
                                          return GestureDetector(
                                            onTap: () async {
                                              if (widget.locationStatus ==
                                                  false) {
                                                checkPermission(
                                                    Permission.location,
                                                    context);
                                              } else {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LocationSearchScreen(
                                                              isSearch: true,
                                                            )));
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: ListTile(
                                                leading: Icon(
                                                    Icons.location_on_outlined),
                                                titleAlignment:
                                                    ListTileTitleAlignment.top,
                                                title: Text(widget.isEdit ==
                                                        false
                                                    ? "Search city or address"
                                                    : widget
                                                        .bookingDataList![
                                                            widget.idx!]
                                                        .PickupAddress!),
                                                titleTextStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 135, 135, 135),
                                                ),
                                              ),
                                              height: 60,
                                              width: sWidth - 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 118, 116, 116))),
                                            ),
                                          );
                                        } else if (state
                                            is PickUpLocationLoadedState) {
                                          bookingDataHelper.pickuplocation =
                                              state.pickuplocation;
                                          return GestureDetector(
                                            onTap: () async {
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LocationSearchScreen(
                                                            isSearch: true,
                                                          )));
                                            },
                                            child: showPickupLocation(sWidth),
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                  ],
                                ),
                              ),

                              //  DropoffAddressCard(isEdit: widget.isEdit,bookingDataHelperList: widget.bookingDataHelperList,idx: widget.idx,),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Drop-off address")),
                                    BlocBuilder<DropoffLocationBloc,
                                        DropoffLocationState>(
                                      builder: (context, state) {
                                        if (state
                                            is DropOffLocationInitialState) {
                                          return GestureDetector(
                                            onTap: () async {
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LocationSearchScreen(
                                                            isSearch: false,
                                                          )));
                                              ;
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: ListTile(
                                                leading: Icon(
                                                    Icons.location_on_outlined),
                                                titleAlignment:
                                                    ListTileTitleAlignment.top,
                                                title: Text(
                                                  widget.isEdit == false
                                                      ? "Search city or address"
                                                      : widget
                                                          .bookingDataList![
                                                              widget.idx!]
                                                          .DropoffAddress!,
                                                ),
                                                titleTextStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 135, 135, 135),
                                                ),
                                              ),
                                              height: 60,
                                              width: sWidth - 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 118, 116, 116))),
                                            ),
                                          );
                                        } else if (state
                                            is DropOffLocationLoadedState) {
                                          bookingDataHelper.dropofflocation =
                                              state.dropoffLocation;
                                          return GestureDetector(
                                            onTap: () async {
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LocationSearchScreen(
                                                            isSearch: false,
                                                          )));
                                            },
                                            child: showDropoffLocation(sWidth),
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 213, 213, 213))),
                          height: 180,
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  isDateEdit = false;
                                  // widget.isEdit =false;
                                  final dateTimeRange =
                                      await showDateRangePicker(
                                          context: context,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000));

                                  if (dateTimeRange != null) {
                                    setState(() {
                                      bookingDataHelper.selectedDate =
                                          dateTimeRange;
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ShowPickupDate(
                                        isEdit: isDateEdit,
                                        bookingDataList: widget.bookingDataList,
                                        idx: widget.idx,
                                        startdate: bookingDataHelper
                                            .selectedDate.start,
                                        startweek: bookingDataHelper
                                            .startWeekFormatter(),
                                        startMonth: bookingDataHelper
                                            .startMonthFormatter()),
                                    Container(
                                      child: Icon(Icons.arrow_forward),
                                    ),
                                    ShowDropoffDate(
                                        isEdit: isDateEdit,
                                        bookingDataList: widget.bookingDataList,
                                        idx: widget.idx,
                                        enddate:
                                            bookingDataHelper.selectedDate.end,
                                        endweek: bookingDataHelper
                                            .endWeekFormatter(),
                                        endMonth: bookingDataHelper
                                            .endMonthFormatter())
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                        onTap: () => pickTimePicker(context),
                                        child: Text(
                                          widget.isEdit == false
                                              ? "${bookingDataHelper.pickedTime.inHours}${" : "}${bookingDataHelper.pickedTime.inMinutes.remainder(60).toString().padLeft(2, "0")}"
                                              : widget
                                                  .bookingDataList![widget.idx!]
                                                  .PickupTime!
                                                  .substring(0, 5),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22,
                                              color: Colors.blue),
                                        )),
                                    GestureDetector(
                                        onTap: () => dropTimePicker(context),
                                        child: Text(
                                          widget.isEdit == false
                                              ? "${bookingDataHelper.dropTime.inHours}${" : "}${bookingDataHelper.dropTime.inMinutes.remainder(60).toString().padLeft(2, "0")}"
                                              : widget
                                                  .bookingDataList![widget.idx!]
                                                  .DropOffTime!
                                                  .substring(0, 5),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22,
                                              color: Colors.blue),
                                        ))
                                  ],
                                ),
                                height: 50,
                                width: MediaQuery.sizeOf(context).width - 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CancellationCard(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromARGB(255, 118, 116, 116))),
                          height: 120,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CheckboxListTile(
                                //    checkColor: Colors.blue,
                                hoverColor: Colors.blue,
                                activeColor: Colors.blue,
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Agreement Policy",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                        fontSize: 18),
                                  ),
                                ),
                                value: widget.isEdit == false
                                    ? agrchcked
                                    : widget.bookingDataList![widget.idx!]
                                        .agrchcked,
                                onChanged: (bool? newvalue) {
                                  setState(() {
                                    agrchcked = newvalue!;
                                  });
                                },
                              ),
                              RichText(
                                  // textAlign: TextAlign.center,

                                  textAlign: TextAlign.justify,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        text:
                                            "I here by agree to the  terms and condition of the agreement"),
                                    TextSpan(
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text: "\n\nSee Details",
                                    )
                                  ]))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<CarBookingBloc, CarBookingState>(
          builder: (context, state) {
            if (state is CarDataLoadedState) {
              return Container(
                  width: sWidth - 10,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Total",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.isEdit == false
                                  ? "₹\t${bookingDataHelper.amountFormatter((int.parse(state.carModel[0].price!)))}"
                                  : "₹\t${widget.bookingDataList![widget.idx!].PaymentAmount!}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.isEdit == false) {
                            addBookingData();
                          } else {
                            updateBooking(widget.bookingDataList!, widget.idx!);
                          }
                        },
                        child: widget.isEdit == false
                            ? BookingButton(
                                agrchcked: agrchcked,
                                bookingDataHelper: bookingDataHelper)
                            : UpdateBookingButton(
                                agrchcked: agrchcked,
                                bookingDataHelper: bookingDataHelper),
                      )
                    ],
                  ));
            } else {
              return Container();
            }
          },
        ));
  }

  Widget showPickupLocation(double sWidth) {
    return SingleChildScrollView(
      child: Container(
        height: 80,
        padding: EdgeInsets.only(left: 10),
        child: ListTile(
          leading: Icon(Icons.location_on_outlined),
          title: Text(
     
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              bookingDataHelper.pickuplocation[0]['description'].toString()),
          titleTextStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
        width: sWidth - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromARGB(255, 118, 116, 116))),
      ),
    );
  }

  Future<dynamic> dropTimePicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done"))
          ],
          content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromARGB(255, 118, 116, 116))),
            height: 200,
            width: MediaQuery.sizeOf(context).width - 10,
            child: CupertinoTimerPicker(
                initialTimerDuration: bookingDataHelper.dropTime,
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (Duration duration) {
                  setState(() {
                    bookingDataHelper.dropTime = duration;
                  });
                }),
          ),
        );
      },
    );
  }

  Future<dynamic> pickTimePicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done"))
          ],
          content: Container(
            height: 200,
            width: MediaQuery.sizeOf(context).width - 10,
            child: CupertinoTimerPicker(
                initialTimerDuration: bookingDataHelper.pickedTime,
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (Duration duration) {
                  setState(() {
                    bookingDataHelper.pickedTime = duration;
                  });
                }),
          ),
        );
      },
    );
  }

  Widget showDropoffLocation(double sWidth) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Icon(Icons.location_on_outlined),
        title: Text(
            maxLines: 10,
            bookingDataHelper.dropofflocation[0]['description'].toString()),
        titleTextStyle: TextStyle(fontSize: 14, color: Colors.black),
      ),
      height: 80,
      width: sWidth - 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 118, 116, 116))),
    );
  }

  addBookingData() async {
    if (bookingDataHelper.pickuplocation.length == 0 &&
        bookingDataHelper.dropofflocation.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text("Please  select pick-up and drop-off address")));
    } else {
      String bookingdays = (bookingDataHelper.selectedDate.end
              .difference(bookingDataHelper.selectedDate.start)
              .inDays)
          .toString();
      String totalPay = (int.parse(bookingDataHelper.carmodelData[0].deposit!) +
              int.parse(bookingDataHelper.carmodelData[0].price!))
          .toString();
      final bookingData = await BookingModel(
          userId: widget.userId,
          CarmodelId: bookingDataHelper.carmodelData[0].id,
          BookingDays: bookingdays,
          PickupDate: bookingDataHelper.selectedDate.start.toString(),
          PickupTime: bookingDataHelper.pickedTime.toString(),
          PickupAddress: bookingDataHelper.pickuplocation[0]['description'],
          DropOffDate: bookingDataHelper.selectedDate.end.toString(),
          DropOffTime: bookingDataHelper.dropTime.toString(),
          DropoffAddress: bookingDataHelper.dropofflocation[0]['description'],
          PaymentAmount: totalPay,
          PaymentStatus: paymentStatus,
          agrchcked: agrchcked);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingConfirmScreen(
              bookingModel: bookingData,
            ),
          ));
    }
  }

  getAddresslatLong(double lat, double long) async {
    await placemarkFromCoordinates(lat, long).then((List<Placemark> placemark) {
      Placemark place = placemark[0];

      setState(() {});
      bookingDataHelper.currentAddress = place.locality;
    });

    Map<String, dynamic> location = {
      "location": bookingDataHelper.currentAddress,
      "location-status": true
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .update(location)
        .then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LocationSearchScreen(
                      isSearch: true,
                    ))));
  }

  Future<void> checkPermission(Permission permission, context) async {
    final status = await permission.request();

    if (status.isGranted) {
      // isLocPermitted = true;
      final position = await Geolocator.getCurrentPosition();

      await getAddresslatLong(position.latitude, position.longitude);

      // final lang = position.latitude;
    } else {
      // isLocPermitted = false;
      Navigator.pop(context);
    }
  }

  updateBooking(List<BookingModel> bookingList, int idx) async {
    String bookingdays = (bookingDataHelper.selectedDate.end
            .difference(bookingDataHelper.selectedDate.start)
            .inDays)
        .toString();


        print("drop ${ bookingDataHelper.dropofflocation[0]['description']}");

    Map<String, dynamic> updateData = {
      "pickup-address": bookingDataHelper.pickuplocation[0]['description'],
      "dropoff-location": bookingDataHelper.dropofflocation[0]['description'],
      "pickup-date": bookingDataHelper.selectedDate.start.toString(),
      "dropoff-date": bookingDataHelper.selectedDate.end.toString(),
      "pick-up time": bookingDataHelper.pickedTime.toString(),
      "drop-off time": bookingDataHelper.dropTime.toString(),
      "booking-days": bookingdays,
    };

    await firestore
        .collection('bookings')
        .doc(bookingList[idx].BookingId)
        .update(updateData)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Booking data is updated",
            style: TextStyle(color: Colors.white),
          )));
      context
          .read<CarBookingBloc>()
          .add(UpcomingCarBookingLogEvent(userId: bookingList[idx].userId!));
      Navigator.pop(context);
    });
  }
}
