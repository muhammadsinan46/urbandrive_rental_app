
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';

class SearchCarCard extends StatelessWidget {
   SearchCarCard({
    super.key,
    required this.list,
    required this.index,
    required this.isLocation,
    required this.userId
  });

  final bool isLocation;
  final String userId;


 final List<CarModels>? list;
final int index;


  @override
  Widget build(BuildContext context) {
   
    return InkWell(
      onTap: (){
        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CarBookingScreen(
                                            locationStatus: isLocation,
                                            carId: list![index].id,
                                            userId: userId,
                                            //  userLocation: userLocation!,
                                          ),
                                        ));
      },
      child: Container(
        decoration: BoxDecoration(),
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 2,
                height: 170,
                
                child:
                CachedNetworkImage(
                  imageUrl: 
                 list![index].images.first
                      
                      ,
                  fit: BoxFit.cover,
                ),
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
                          "${list![index].brand} ${list![index].model}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "₹ ${list![index].price!}",
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
                        list![index].category!,
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
                        child: Text(
                            "${list![index].seats!} seats",
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
                        child: Text(
                           list![index].transmit!,
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
    );
  }
}
