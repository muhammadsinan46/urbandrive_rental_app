// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/application/dropoff_location_bloc/dropoff_location_bloc.dart';
import 'package:urbandrive/application/pickup_location_bloc/location_bloc.dart';
import 'package:urbandrive/domain/booking_model.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/presentation/loading_pages/car_booking_shimmer.dart';
import 'package:urbandrive/presentation/pages/booking_confirm.dart';
import 'package:urbandrive/presentation/pages/location_search.dart';

class CarBookingScreen extends StatefulWidget {
  CarBookingScreen(
      {super.key,
      required this.carId,
      required this.userId,
      //required this.userLocation,
      required this.locationStatus});
  final bool? locationStatus;
//final String? userLocation;
  final String carId;
  final String userId;

  @override
  State<CarBookingScreen> createState() => _CarBookingScreenState();
}

class _CarBookingScreenState extends State<CarBookingScreen> {
  DateTime? startdate;

  List<CarModels> carmodelData = [];

  List<Widget> carousalitems = [];
  String? currentAddress;

  //= DateTimeRange(start: DateTime.now(), end: DateTime.now());
  var amtformat = NumberFormat("###,###.00#", "en_US");

  String? picklocation;

  List<dynamic> pickuplocation = [];

  List<dynamic> dropofflocation = [];

  DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  Duration pickedTime = Duration(
      hours: int.parse(DateFormat('kk').format(DateTime.now())),
      minutes: int.parse(DateFormat('mm').format(DateTime.now())));

  Duration dropTime = Duration(
      hours: int.parse(DateFormat('kk').format(DateTime.now())),
      minutes: int.parse(DateFormat('mm').format(DateTime.now())));

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool agrchcked = false;
  String paymentStatus = "pending";

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.sizeOf(context).width;

    context
        .read<CarBookingBloc>()
        .add(CardDataLoadedEvent(modelId: widget.carId));
    //context.read<LocationBloc>().add(GetLocationEvent(pickedLocation: pickedLocation))
    final startdate = selectedDate.start;

    String startMonth = DateFormat('MMMM').format(startdate);
    String startweek = DateFormat('EEE').format(startdate);

    final enddate = selectedDate.end;

    String endMonth = DateFormat('MMMM').format(enddate);
    String endweek = DateFormat('EEE').format(enddate);

    return Scaffold(
        body: BlocBuilder<CarBookingBloc, CarBookingState>(
          builder: (context, state) {
            if (state is CarDataLoadingState) {
              return ShimmerCarBookingScreen();
            } else if (state is CarDataLoadedState) {
              carmodelData = state.carModel;

              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverLayoutBuilder(
                      builder: (context, constraints) {
                        final scrolled = constraints.scrollOffset > 0;

                        return SliverAppBar(
                          leading: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: scrolled ? Colors.white : Colors.blue,
                            ),
                          ),
                          actions: [
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.share,
                                  color: scrolled ? Colors.white : Colors.blue,
                                )),
                          ],
                          title: scrolled
                              ? Text(
                                  "${carmodelData[0].brand} ${carmodelData[0].model}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              : null,
                          backgroundColor: scrolled ? Colors.blue : null,
                          pinned: true,
                        );
                      },
                    )
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                //  decoration: BoxDecoration(border: Border.all()),
                                width: MediaQuery.sizeOf(context).width * 2,
                                height: 200,
                                child: CarouselSlider.builder(
                                    itemCount: carmodelData[0].images.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final List carmodelImages =
                                          carmodelData[0].images;

                                      return Card(
                                          clipBehavior: Clip.antiAlias,
                                          child: CachedNetworkImage(
                                            imageUrl: carmodelImages[index],
                                            fit: BoxFit.cover,
                                          ));
                                    },
                                    options: CarouselOptions(
                                        aspectRatio: 1,
                                        autoPlay: true,
                                        enlargeCenterPage: true)),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                //    padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 213, 213, 213)),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                width: sWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${carmodelData[0].brand!} ${carmodelData[0].model}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "₹ ${carmodelData[0].price} / day",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 213, 213, 213))),
                          height: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Car Features",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                height: 80,
                                width: sWidth,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Card(
                                      color: Color.fromARGB(255, 236, 249, 255),
                                      child: Container(
                                        height: 50,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'lib/assets/images/car.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Text(carmodelData[0].model!),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Color.fromARGB(255, 236, 249, 255),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'lib/assets/images/luggage.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Text(carmodelData[0].baggage!),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Color.fromARGB(255, 236, 249, 255),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'lib/assets/images/car-seat.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Text(carmodelData[0].seats!),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Color.fromARGB(255, 236, 249, 255),
                                      child: Container(
                                        height: 50,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'lib/assets/images/gas-pump.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Text(carmodelData[0].fuel!),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Color.fromARGB(255, 236, 249, 255),
                                      child: Container(
                                        height: 50,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'lib/assets/images/gear-shift.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Text(carmodelData[0].transmit!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
                                    Text("₹ ${carmodelData[0].deposit}")
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                child: Column(
                                  children: [
                                    Text("Free Kms"),
                                    Text(carmodelData[0].freekms!)
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                child: Column(
                                  children: [
                                    Text("Extra Kms"),
                                    Text(carmodelData[0].extrakms!)
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
                                                checkPermission(Permission.location, context);
                                              } else {
                                              await   Navigator.push(
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
                                                title: Text(
                                                  "Search city or address",
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
                                            is PickUpLocationLoadedState) {
                                          pickuplocation = state.pickuplocation;
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
                                            child: SingleChildScrollView(
                                              child: Container(
                                                height: 80,

                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: ListTile(
                                                  leading: Icon(Icons
                                                      .location_on_outlined),
                                                  title: Text(
                                                      maxLines: 10,
                                                      pickuplocation[0]
                                                              ['description']
                                                          .toString()),
                                                  titleTextStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),

                                                //  Align(
                                                //     alignment: Alignment.centerLeft,
                                                //     child: Text(
                                                //       overflow: TextOverflow.clip,
                                                //      ,
                                                //       style: TextStyle(
                                                //           fontSize: 12,
                                                //           color: Color.fromARGB(
                                                //               255, 150, 150, 150)),
                                                //     )),
                                                //   height: 70,
                                                width: sWidth - 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255,
                                                            118,
                                                            116,
                                                            116))),
                                              ),
                                            ),
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                  ],
                                ),
                              ),
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
                                                          )));;
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
                                                  "Search city or address",
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
                                          dropofflocation =
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
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: ListTile(
                                                leading: Icon(
                                                    Icons.location_on_outlined),
                                                title: Text(
                                                    maxLines: 10,
                                                    dropofflocation[0]
                                                            ['description']
                                                        .toString()),
                                                titleTextStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              height: 80,
                                              width: sWidth - 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 118, 116, 116))),
                                            ),
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
                                  final dateTimeRange =
                                      await showDateRangePicker(
                                          context: context,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000));

                                  if (dateTimeRange != null) {
                                    setState(() {
                                      selectedDate = dateTimeRange;
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 150,
                                      child: Center(
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.blue),
                                                children: [
                                                  TextSpan(
                                                      text: "Pick-Up",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  TextSpan(
                                                      text:
                                                          "\n${startdate.day}",
                                                      style: TextStyle(
                                                          fontSize: 60)),
                                                  TextSpan(
                                                      style: TextStyle(
                                                          wordSpacing: 10),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                "\n ${startweek} "),
                                                        TextSpan(text: "|"),
                                                        TextSpan(
                                                            text:
                                                                " ${startMonth}"),
                                                        //  TextSpan(
                                                        //   text: "\n\n10:00",
                                                        //   style: TextStyle(
                                                        //       fontSize: 20,
                                                        //       wordSpacing: 12)),
                                                      ]),
                                                ])),
                                      ),
                                    ),
                                    Container(
                                      child: Icon(Icons.arrow_forward),
                                    ),
                                    Container(
                                      height: 120,
                                      width: 150,
                                      child: Center(
                                        child: RichText(
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    leadingDistribution:
                                                        TextLeadingDistribution
                                                            .even),
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.blue),
                                                children: [
                                                  TextSpan(
                                                      text: "Drop -Off\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  TextSpan(
                                                      text: "${enddate.day}",
                                                      style: TextStyle(
                                                          fontSize: 60)),
                                                  TextSpan(
                                                      style: TextStyle(
                                                        wordSpacing: 10,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                "\n${endweek}"),
                                                        TextSpan(text: "|"),
                                                        TextSpan(
                                                            text:
                                                                " ${endMonth} "),

                                                        // TextSpan(
                                                        //     text: "\n\n10:00",
                                                        //     style: TextStyle(
                                                        //         fontSize: 20,
                                                        //         wordSpacing: 12)),
                                                      ]),
                                                ])),
                                      ),
                                    )
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
                                        onTap: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Done"))
                                                  ],
                                                  content: Container(
                                                    height: 200,
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width -
                                                        10,
                                                    child: CupertinoTimerPicker(
                                                        initialTimerDuration:
                                                            pickedTime,
                                                        mode:
                                                            CupertinoTimerPickerMode
                                                                .hm,
                                                        onTimerDurationChanged:
                                                            (Duration
                                                                duration) {
                                                          setState(() {
                                                            pickedTime =
                                                                duration;
                                                          });
                                                        }),
                                                  ),
                                                );
                                              },
                                            ),
                                        child: Text(
                                          "${pickedTime.inHours}${" : "}${pickedTime.inMinutes.remainder(60).toString().padLeft(2, "0")}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22,
                                              color: Colors.blue),
                                        )),
                                    GestureDetector(
                                        onTap: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Done"))
                                                  ],
                                                  content: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    118,
                                                                    116,
                                                                    116))),
                                                    height: 200,
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width -
                                                        10,
                                                    child: CupertinoTimerPicker(
                                                        initialTimerDuration:
                                                            dropTime,
                                                        mode:
                                                            CupertinoTimerPickerMode
                                                                .hm,
                                                        onTimerDurationChanged:
                                                            (Duration
                                                                duration) {
                                                          setState(() {
                                                            dropTime = duration;
                                                          });
                                                        }),
                                                  ),
                                                );
                                              },
                                            ),
                                        child: Text(
                                          "${dropTime.inHours}${" : "}${dropTime.inMinutes.remainder(60).toString().padLeft(2, "0")}",
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
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color.fromARGB(255, 118, 116, 116))),
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            height: 100,
                            width: MediaQuery.sizeOf(context).width,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(5),
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  fontSize: 18),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text("Cancellation Charges"),
                              ),
                              subtitle: Text(
                                "Cancellation charges will be applied as per the policy",
                              ),
                              trailing: TextButton(
                                // style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.green))),
                                onPressed: () {},
                                child: Text(
                                  "Know more",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          255, 62, 158, 206)),
                                ),
                              ),
                            )),
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
                                value: agrchcked,
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
                                        ..onTap = () {
                                          //   DatePicker(selectedDate: selectedDate!,pickedTime:pickedTime! ,dropTime: droppedTime!,),
                                        },
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
                              "₹\t${amtformat.format(int.parse(state.carModel[0].price!))}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: addBookingData,
                        child: Container(
                          decoration: BoxDecoration(
                              color: agrchcked == false &&
                                      pickuplocation.length == 0 &&
                                      dropofflocation.length == 0
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
                        ),
                      )
                    ],
                  ));
            } else {
              return Container();
            }
          },
        ));
  }

  addBookingData() async {
    if (pickuplocation.length == 0 && dropofflocation.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text("Please  select pick-up and drop-off address")));
    } else {
      print("calling");
      String bookingdays =
          (selectedDate.end.difference(selectedDate.start).inDays).toString();
      String totalPay = (int.parse(carmodelData[0].deposit!) +
              int.parse(carmodelData[0].price!))
          .toString();
      final bookingData = await BookingModel(
          userId: widget.userId,
          CarmodelId: carmodelData[0].id,
          BookingDays: bookingdays,
          PickupDate: selectedDate.start.toString(),
          PickupTime: pickedTime.toString(),
          PickupAddress: pickuplocation[0]['description'],
          DropOffDate: selectedDate.end.toString(),
          DropOffTime: dropTime.toString(),
          DropoffAddress: dropofflocation[0]['description'],
          PaymentAmount: totalPay,
          PaymentStatus: paymentStatus,
          agrchcked: agrchcked);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingConfirmScreen(
              bookedData: bookingData,
            ),
          ));
    }
  }

  getAddresslatLong(double lat, double long) async {
    await placemarkFromCoordinates(lat, long).then((List<Placemark> placemark) {
      Placemark place = placemark[0];

      setState(() {});
      currentAddress = place.locality;
    });

    Map<String, dynamic> location = {
      "location": currentAddress,
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
}

// class PickLocationScreen extends StatelessWidget {
//    PickLocationScreen({
//     super.key,
//     required this.picklocation,
//     required this.sWidth,
//   });

//   final String? picklocation;
//   final double sWidth;
//         int? idx;
//   @override
//   Widget build(BuildContext context) {

//     return BlocBuilder<LocationBloc, LocationState>(
//       builder: (context, state) {
//           print(state.runtimeType);
//         if(state is LocationInitialState){
//             return ;

//         }
//          if(state is LocationLoadedState){
//               final data = state.locationList![idx!];
//               print("date is $data");

//             return GestureDetector(
//           onTap: () async{
//         idx = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => LocationSearchScreen()));
//           },
//           child: Container(
//             padding: EdgeInsets.only(left: 10),
//             // child:
//             //  Align(
//             //     alignment: Alignment.centerLeft,
//             //     child: Text(
//             //           data!['description'],
//             //       style: TextStyle(color: Color.fromARGB(255, 150, 150, 150)),
//             //     )),
//             height: 50,
//             width: sWidth - 50,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Color.fromARGB(255, 118, 116, 116))),
//           ),
//         );
//         }
//         return Container();
//       },
//     );
//   }
// }
