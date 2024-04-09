

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';

class CarModelMainCard extends StatelessWidget {
  const CarModelMainCard({
    super.key,
    required this.bookingDataHelper,
    required this.sWidth,
  });

  final BookingScreenHelper bookingDataHelper;
  final double sWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                itemCount: bookingDataHelper
                    .carmodelData[0].images.length,
                itemBuilder:
                    (context, index, realIndex) {
                  final List carmodelImages =
                      bookingDataHelper
                          .carmodelData[0].images;
    
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
                borderRadius:
                    BorderRadius.circular(10)),
            height: 50,
            width: sWidth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${bookingDataHelper.carmodelData[0].brand!} ${bookingDataHelper.carmodelData[0].model}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w500),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          Text(
                            " ${bookingDataHelper.carmodelData[0].rating!.isNaN ? 0.00 : bookingDataHelper.carmodelData[0].rating}",
                            style: TextStyle(
                                fontWeight:
                                    FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "₹ ${bookingDataHelper.carmodelData[0].price} / day",
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
    );
  }
}