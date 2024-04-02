



import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';

class CarousalFirst extends StatelessWidget {
   CarousalFirst({
    super.key,
    required this.sWidth,
    required this.carmodelsList,
    required this.userId,
  });

  final double sWidth;
  List<CarModels> carmodelsList =[];

  String? userId;

  

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      //  color: Colors.black26,
      child: 
            //  CarouselSlider(
            //                   items: carmodelsList[0].images,
            //                   options: CarouselOptions(
            //                     autoPlay: false,
            //                     aspectRatio: 2.0,
            //                     // enlargeCenterPage: true
            //                   )),
      
      Container(
        width: sWidth,
        
        decoration: BoxDecoration(
          color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
               carmodelsList[20].images[1],
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10)),
        height: 250,
        child: Stack(
          children: [

            Positioned(
              left: 10,
              top: 30,
              child: Text("${carmodelsList[20].brand} ${carmodelsList[20].model}",style: TextStyle(
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
                           Navigator.push(context, MaterialPageRoute(builder: (context) => CarBookingScreen(carId:  carmodelsList[20].id, userId: userId!, locationStatus: true, isEdit: false,),));
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
      ),
    );
  }
}
