// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';

class HistoryTabScreen extends StatelessWidget {
   HistoryTabScreen({super.key, required this.userId });


    List<BookingModel>? bookingHistoryList;
    String userId;

  @override
  Widget build(BuildContext context) {
     context.read<CarBookingBloc>().add(HistoryCarBookingLogEvent(userId: userId));
    return BlocBuilder<CarBookingBloc, CarBookingState>(
              builder: (context, state) {
                if (state is HistoryCarBookingState) {
                  bookingHistoryList = state.bookingHistory;
                  print(bookingHistoryList);
         
                  return Container(
                      child: bookingHistoryList!.length != 0
                          ? ListView.builder(
                              itemCount: bookingHistoryList!.length,
                              itemBuilder: (context, index) {
                                
                                return Card(
                                  color:
                                      const Color.fromARGB(255, 237, 247, 255),
                                  child: Container(
                                
                                    height: 240,
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: ListTile(
                                            // trailing: Text(
                                            //     "${bookingHistoryList![index].PaymentStatus}"),
                                            //subtitle: Text(),
                                            title: Text(
                                              "${bookingHistoryList![index].carmodel!['brand']}"
                                              "\t${bookingHistoryList![index].carmodel!['model']}",
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
                                                      BorderRadius.circular(
                                                          10)),
                                              width: 100,
                                              height: 80,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${bookingHistoryList![index].carmodel!['carImages'][0]}",
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
                                                    width: MediaQuery.sizeOf(
                                                                context)
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

                                                         
                                                            "${bookingHistoryList![index].PickupDate}\t ${bookingHistoryList![index].pickMonth}"
                                                             "-\t${bookingHistoryList![index].DropOffDate}\t${bookingHistoryList![index].dropMonth}",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    height: 40,
                                                    width: MediaQuery.sizeOf(
                                                                context)
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
                                                              .location_on),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width -
                                                                  150,
                                                          child: Text(
                                                            maxLines: 5,
                                                            "${bookingHistoryList![index].PickupAddress}",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    height: 40,
                                                    width: MediaQuery.sizeOf(
                                                                context)
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
                                                              .location_on),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width -
                                                                  150,
                                                          child: Text(
                                                            maxLines: 5,
                                                            "${bookingHistoryList![index].DropoffAddress}",
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
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "Rebook",
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
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                  "Looks Empty. No history bookings available",
                                  style: TextStyle(color: Colors.grey))));
                }
                return Center(
                    child: Text("Looks Empty. No history bookings available",
                        style: TextStyle(color: Colors.grey)));
              },
            );
  }
}