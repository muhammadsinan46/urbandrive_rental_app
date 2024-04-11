



// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';

class CarousalFirst extends StatelessWidget {
   CarousalFirst({
    super.key,
    required this.sWidth,
    required this.carModelsList,
    required this.userId,
  });

  final double sWidth;
  List<CarModels> carModelsList =[];

  String? userId;

  

  @override
  Widget build(BuildContext context) {
    return Container(
   

    //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),       color: Colors.white,),
      width: sWidth,
      height: 250,
      child: Stack(
        children: [
              CachedNetworkImage(
               placeholder: (context, url) => Center(child: LoadingAnimationWidget.twoRotatingArc(color:  const Color.fromARGB(255, 119, 175, 221), size: 50)),
                imageUrl:  carModelsList[20].images[1], fit: BoxFit.contain,),
          Positioned(
            left: 10,
            top: 30,
            child: Text("${carModelsList[20].brand} ${carModelsList[20].model}",style: TextStyle(
              shadows: [Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 140, 140, 140),
    )],
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),)),
          Positioned(
            top: 20,
            left: 220,
     
            child: Container(
              // margin: EdgeInsets.only(left: 50),
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
             
              ),
            
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                inherit: false,
                                  fontSize:20, color: Colors.white,shadows: [Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 140, 140, 140),
    )]
                                  
                                  ),
                              children: [
                            TextSpan(text: "Flat "),
                            TextSpan(
                                text: "25% OFF",
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " on"),
                            TextSpan(text: "\nyour next ride"),
                          ])),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    height: 40,
                    width: 140,
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => CarBookingScreen(carId:  carModelsList[20].id, userId: userId!, locationStatus: true, isEdit: false,),));
                      },
                      child: Text(
                        "BOOK NOW",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
