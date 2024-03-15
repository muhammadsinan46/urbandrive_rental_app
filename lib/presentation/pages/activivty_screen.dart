import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/domain/booking_model.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key, required this.userId});

  final String userId;

  List<BookingModel>? bookingdata;

  @override
  Widget build(BuildContext context) {
    print(userId);
    context.read<CarBookingBloc>().add(CarBookingLogEvent(userId: userId));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "History",
              ),
            ]),
          ),
          body: TabBarView(children: [
            BlocBuilder<CarBookingBloc, CarBookingState>(
              builder: (context, state) {
                if (state is CarBookingLogState) {
                  bookingdata = state.bookingdata;
                  return Container(
                    child: ListView.builder(
                      itemCount: bookingdata!.length,
                      itemBuilder: (context, index) {

                        DateTime pickupDate = DateTime.parse(bookingdata![index].DropOffDate!);
                        DateTime dropOffDate = DateTime.parse(bookingdata![index].DropOffDate!);
                        String  pickMonth = DateFormat('MMM').format(DateTime(0, pickupDate.month));
                        String dropMonth = DateFormat('MMM').format(DateTime(0, dropOffDate.month));
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
                                        "\t${bookingdata![index].carmodel!['model']}", style: TextStyle(fontWeight: FontWeight.w600),),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                           
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.only(left: 5),
                                      decoration:
                                          BoxDecoration( borderRadius: BorderRadius.circular(10)),
                                      width: 100,
                                      height: 80,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${bookingdata![index].carmodel!['carImages'][0]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                           
                                            height: 40,
                                            width: MediaQuery.sizeOf(context)
                                                    .width -
                                                120,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child:Icon(Icons.event_available_rounded) ,),

                                                  Container(
                                                    width: MediaQuery.sizeOf(context).width-150,
                                                    child: Text(
                                                    
                                                maxLines: 5,
                                              "${pickupDate.day}\t ${pickMonth}"  "-\t${dropOffDate.day}\t${dropMonth}",
                                                style: TextStyle(fontSize: 16),
                                              ),)
                                            ],)
                                            
                                            
                                            
                                            ),
                                       
                                        Container(
                                           
                                            height: 40,
                                            width: MediaQuery.sizeOf(context)
                                                    .width -
                                                120,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child:Icon(Icons.location_on) ,),

                                                  Container(
                                                    width: MediaQuery.sizeOf(context).width-150,
                                                    child: Text(
                                                    
                                                maxLines: 5,
                                                "${bookingdata![index].PickupAddress}",
                                                style: TextStyle(fontSize: 12),
                                              ),)
                                            ],)
                                            ),
                                                     Container(
                                           
                                            height: 40,
                                            width: MediaQuery.sizeOf(context)
                                                    .width -
                                                120,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child:Icon(Icons.location_on) ,),

                                                  Container(
                                                    width: MediaQuery.sizeOf(context).width-150,
                                                    child: Text(
                                                    
                                                maxLines: 5,
                                                "${bookingdata![index].DropoffAddress}",
                                                style: TextStyle(fontSize: 12),
                                              ),)
                                            ],)
                                            
                                            
                                            
                                            ),
                                            
                                      ],
                                    ),
                                  ],
                                ),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.white,),
                                    child: Center(child: Text("Cancel")),
                              
                                    height: 40,width: 120,),
                                    SizedBox(width: 10,),
                                       Container(
                                        child: Center(child: Text("Modify", style: TextStyle(color: Colors.white),),),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.blue,),
                                    height: 40,width: 120,)
                                ],)
                              ],
                            ),
                          ),
                        );

                        //ListTile(title: Text("${bookingdata![index].BookingId}"));
                      },
                    ),
                  );
                } else if (state is CarDataLoadingState) {
                  return Container(
                    child: Text("loading.."),
                  );
                }
                return Container();
              },
            ),
            HistoryTab()
          ])),
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("upcoming"),
          );
        },
      ),
    );
  }
}
