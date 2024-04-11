

// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:urbandrive/application/favourite_bloc/favourite_bloc.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/infrastructure/favourite_model/fav_model.dart';

class ShowCarDetailsCard extends StatelessWidget {
  ShowCarDetailsCard(
      {super.key, required this.carModelsList, required this.index});
  final index;
  final List<CarModels> carModelsList;
  List<FavouriteModel> favList = [];

  @override
  Widget build(BuildContext context) {
    context.read<FavouriteBloc>().add(FetchFavouriteEvent());
    return Container(
      decoration: BoxDecoration(),
      child: Card(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 2,
                  height: 170,
                  child: CachedNetworkImage(
                     errorWidget: (context, url, error) => Icon(Icons.error),
                       placeholder: (context, url) => Center(child: LoadingAnimationWidget.twoRotatingArc(color:  const Color.fromARGB(255, 119, 175, 221), size: 50)),
                                          
                    imageUrl: carModelsList[index].images.last,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${carModelsList[index].brand!} ${carModelsList[index].model}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "₹ ${carModelsList[index].price!}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                            child: Text(
                          carModelsList[index].category!,
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
                          child: Text("${carModelsList[index].seats!} seats",
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
                          child: Text(carModelsList[index].transmit!,
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
            Positioned(
              left: 2,
              top: 2,
              child: BlocBuilder<FavouriteBloc, FavouriteState>(
                builder: (context, state) {
                  Color iconColor = Colors.black;

                  if (state is FavouriteLoadedState) {
                    favList = state.favlist;
                    if (index >= 0 && index < state.favlist.length) {
               
                      if (favList[index].favId == carModelsList[index].id) {
                        iconColor = Colors.red;
                      }
                    }
                  }
                  return CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                        
                            context.read<FavouriteBloc>().add(AddFavouriteEvent(
                                  favModel: carModelsList[index],
                                ));
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text("${carModelsList[index].brand} ${carModelsList[index].model} added into favourite list")));
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: iconColor,
                          )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}