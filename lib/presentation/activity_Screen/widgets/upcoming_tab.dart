// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';

class UpcomingTabScreen extends StatelessWidget {
   UpcomingTabScreen({super.key, required this.userId});


    List<BookingModel>? bookingdata;
    String  userId;

  @override
  Widget build(BuildContext context) {
       context.read<CarBookingBloc>().add(UpcomingCarBookingLogEvent(userId: userId));
    
    return   BlocBuilder<CarBookingBloc, CarBookingState>(
              builder: (context, state) {
                if (state is UpcomingCarBookingLogState) {
                  bookingdata = state.bookingdata;

                  
                  return bookingdata!.length != 0
                      ? Container(
                          child: ListView.builder(
                            itemCount: bookingdata!.length,
                            itemBuilder: (context, index) {
                        
                              return Card(
                                color: const Color.fromARGB(255, 237, 247, 255),
                                child: Container(
                                  //  color: Colors.lightBlue,
                                  height: 240,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: ListTile(
                                          trailing: Text(
                                              "${bookingdata![index].PaymentStatus}"),
                                          //subtitle: Text(),
                                          title: Text(
                                            "${bookingdata![index].carmodel!['brand']}"
                                            "\t${bookingdata![index].carmodel!['model']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            margin: EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 100,
                                            height: 80,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${bookingdata![index].carmodel!['carImages'][1]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 40,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width -
                                                          120,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: Icon(Icons
                                                            .event_available_rounded),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width -
                                                                150,
                                                        child: Text(
                                                          maxLines: 5,
                                                 
                                                          "${bookingdata![index].PickupDate}\t ${bookingdata![index].pickMonth}"
                                                          "-\t${bookingdata![index].DropOffDate}\t${bookingdata![index].dropMonth}",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                  height: 40,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width -
                                                          120,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: Icon(
                                                            Icons.location_on),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width -
                                                                150,
                                                        child: Text(
                                                          maxLines: 5,
                                                          "${bookingdata![index].PickupAddress}",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                  height: 40,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width -
                                                          120,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: Icon(
                                                            Icons.location_on),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width -
                                                                150,
                                                        child: Text(
                                                          maxLines: 5,
                                                          "${bookingdata![index].DropoffAddress}",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title:
                                                      Text("Cancel the trip"),
                                                  content: Text(
                                                      "Are you sure to Cancel this trip"),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'bookings')
                                                              .doc(bookingdata![
                                                                      index]
                                                                  .BookingId)
                                                              .delete()
                                                              .then((value){ 
                                                                context.read<CarBookingBloc>().add(UpcomingCarBookingLogEvent(userId: bookingdata![index].userdata!['uid']));
                                                                Navigator.pop(
                                                                      context);},
                                                                 );
                                                        },
                                                        child: Text("Confirm")),
                                                    ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("Cancel")),
                                                  ],
                                                );
                                              },
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              child:
                                                  Center(child: Text("Cancel")),
                                              height: 40,
                                              width: 120,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(

                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CarBookingScreen(
                                                isEdit: true,
                                            locationStatus: true,
                                            carId: bookingdata![index].CarmodelId!,
                                            userId: userId,
                                            bookingDataList: bookingdata,
                                            idx: index,
                                            
                                            //  userLocation: userLocation!,
                                          ),));
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "Modify",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue,
                                              ),
                                              height: 40,
                                              width: 120,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );

                              //ListTile(title: Text("${bookingdata![index].BookingId}"));
                            },
                          ),
                        )
                      : Container(
                          child: Center(
                          child: Text(
                            "Looks Empty. No upcoming trips available",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ));
                } else if (state is CarDataLoadingState) {
                  return Center(
                      child: Text("Looks Empty. No upcoming trips available",
                          style: TextStyle(color: Colors.grey)));
                }
                return Container();
              },
            );
  }


  dateFormater(){


  }
}