import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/application/location_bloc/location_bloc.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/presentation/pages/location_search.dart';

class CarBookingScreen extends StatelessWidget {
  CarBookingScreen({super.key, required this.carId});

  final String carId;

  DateTime? startdate;

  List<CarModels> carmodelData = [];

  List<Widget> carousalitems = [];

  final DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  String? picklocation;

  // getlocation() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   picklocation = pref.get('pickedaddress').toString();
  //   print("value is added $picklocation");
  // }

  @override
  Widget build(BuildContext context) {

    final sWidth = MediaQuery.sizeOf(context).width;

    context.read<CarBookingBloc>().add(CardDataLoadedEvent(modelId: carId));
    //context.read<LocationBloc>().add(GetLocationEvent(pickedLocation: pickedLocation))

    return Scaffold(
      body: BlocBuilder<CarBookingBloc, CarBookingState>(
        builder: (context, state) {
          if (state is CarDataLoadingState) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final scrolled = constraints.scrollOffset > 0;

                      return SliverAppBar(
                        actions: [Icon(Icons.share)],
                        title: scrolled ? Text("data") : null,
                        backgroundColor: scrolled
                            ? const Color.fromARGB(255, 241, 249, 255)
                            : null,
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
                    children: [
                      Container(
                        height: 350,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 2,

                                height: 220,
                                // child: CarouselSlider(
                                //     items: carousalitems,
                                //     options: CarouselOptions(
                                //       autoPlay: true,
                                //       aspectRatio: 1,
                                //       // enlargeCenterPage: true
                                //     )),
                                // decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //         fit: BoxFit.cover,
                                //         image: NetworkImage(
                                //   " carmodelslist[index]"

                                //               ,
                                //         ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "model}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "  price!",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "9am -9pm",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Center(
                                          child: Text(
                                        "   category",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                      height: 30,
                                      width: 80,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                        child: Text("seats",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      height: 30,
                                      width: 80,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                        child: Text(" carm",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      height: 30,
                                      width: 80,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        height: 200,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                      Container(
                        color: Colors.cyan,
                        height: 150,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                      Container(
                        color: Colors.black54,
                        height: 400,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CarDataLoadedState) {
            carmodelData = state.carModel;
            print("car images are ${carmodelData[0].images}");

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final scrolled = constraints.scrollOffset > 0;

                      return SliverAppBar(
                        actions: [Icon(Icons.share)],
                        title: scrolled
                            ? Text(
                                "${carmodelData[0].brand} ${carmodelData[0].model}")
                            : null,
                        backgroundColor: scrolled
                            ? const Color.fromARGB(255, 241, 249, 255)
                            : null,
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
                                color:
                                    const Color.fromARGB(255, 213, 213, 213))),
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
                                color:
                                    const Color.fromARGB(255, 213, 213, 213))),
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
                      DatePicker(selectedDate: selectedDate),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 213, 213, 213))),
                        height: 150,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                  onTap: () async{
                                 picklocation=await   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocationSearchScreen()));


                                              
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                         "picklocation",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 150, 150, 150)),
                                        )),
                                    height: 50,
                                    width: sWidth - 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 118, 116, 116))),
                                  ),
                                )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black54,
                        height: 400,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  // dateTimePicker(context)async{

  //   try{
  //      dateTimeList =await showOmniDateTimeRangePicker(context: context,
  //   startInitialDate: DateTime.now(),
  //   endInitialDate: DateTime.now(),
  //   startFirstDate: DateTime(1600).subtract(Duration(days: 3652)),
  //   startLastDate: DateTime.now().add(Duration(days: 3652)),
  //   endFirstDate: DateTime(1600).subtract(Duration(days: 3652)),
  //   endLastDate: DateTime.now().add(Duration(days: 3652)),

  //   transitionBuilder: (context, anim1  , anim2, child) {
  //     return FadeTransition(opacity: anim1.drive(Tween(begin: 0,end:1 )),child: child,);

  //   },
  //   selectableDayPredicate: (dateTime) {
  //     if(dateTime ==DateTime.now()){
  //       return false;

  //     }else{
  //       return true;
  //     }

  //   },
  //   );
  // print(dateTimeList!.length);

  //   }catch(e){

  //     print("error is${e.toString()}");
  //   }
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

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.selectedDate,
  });

  final DateTimeRange selectedDate;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  @override
  Widget build(BuildContext context) {
    final startdate = widget.selectedDate.start;

    String startMonth = DateFormat('MMMM').format(startdate);
    String startweek = DateFormat('EEE').format(startdate);

    final enddate = widget.selectedDate.end;

    String endMonth = DateFormat('MMMM').format(enddate);
    String endweek = DateFormat('EEE').format(enddate);
    return GestureDetector(
      onTap: () async {
        final dateTimeRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));

        if (dateTimeRange != null) {
          setState(() {
            selectedDate = dateTimeRange;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: const Color.fromARGB(255, 213, 213, 213))),
        height: 160,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.blue),
                        children: [
                          TextSpan(
                              text: "Pick-Up",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "\n${startdate.day}",
                              style: TextStyle(fontSize: 60)),
                          TextSpan(
                              style: TextStyle(wordSpacing: 10),
                              children: [
                                TextSpan(text: "\n ${startweek} "),
                                TextSpan(text: "|"),
                                TextSpan(text: " ${startMonth}"),
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
              height: 150,
              width: 150,
              child: Center(
                child: RichText(
                    textHeightBehavior: TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even),
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.blue),
                        children: [
                          TextSpan(
                              text: "Drop -Off\n",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "${enddate.day}",
                              style: TextStyle(fontSize: 60)),
                          TextSpan(
                              style: TextStyle(
                                wordSpacing: 10,
                              ),
                              children: [
                                TextSpan(text: "\n${endweek}"),
                                TextSpan(text: "|"),
                                TextSpan(text: " ${endMonth} "),

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
    );
  }
}
