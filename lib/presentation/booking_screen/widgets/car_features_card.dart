


import 'package:flutter/material.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';

class CarFeaturesCard extends StatelessWidget {
  const CarFeaturesCard({
    super.key,
    required this.sWidth,
    required this.bookingDataHelper,
  });

  final double sWidth;
  final BookingScreenHelper bookingDataHelper;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        'lib/assets/icons/car.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(bookingDataHelper
                          .carmodelData[0].category!),
                    ],
                  ),
                ),
              ),
              Card(
                color: Color.fromARGB(255, 236, 249, 255),
                child: Container(
                  height: 50,
                  width: 70,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/icons/luggage.png',
                        height: 20,
                        width: 40,
                      ),
                      Text(bookingDataHelper
                          .carmodelData[0].baggage!),
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
                        'lib/assets/icons/car-seat.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(bookingDataHelper
                          .carmodelData[0].seats!),
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
                        'lib/assets/icons/gas-pump.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(bookingDataHelper
                          .carmodelData[0].fuel!),
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
                        'lib/assets/icons/gear-shift.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(bookingDataHelper
                          .carmodelData[0].transmit!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
