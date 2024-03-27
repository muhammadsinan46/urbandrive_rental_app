import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/infrastructure/favourite_model/fav_model.dart';
import 'package:urbandrive/application/favourite_bloc/favourite_bloc.dart';

class FavouriteCard extends StatelessWidget {
   FavouriteCard({
    super.key,
    required this.favList,
    required this.idx
  });

  final List<FavouriteModel> favList;

  final int idx;

  @override
  Widget build(BuildContext context) {
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
        imageUrl: favList[idx].carmodel['carImages']![0],
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
                "${favList[idx].carmodel['brand']} ${favList[idx].carmodel['model']}",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "₹ ${favList[idx].carmodel['price']}",
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
             favList[idx].carmodel['category']!,
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
              child: Text("${favList[idx].carmodel['seats']} seats",
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
              child: Text(favList[idx].carmodel['transmit']!,
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
                  child: CircleAvatar(
    backgroundColor: Colors.white,
    child:  IconButton(
            onPressed: () {

              context.read<FavouriteBloc>().add(RemoveFavouriteEvent(favId: favList[idx].favId));
            },
            icon: Icon(Icons.favorite_border_outlined))
                  ),
                )
              ],
            ),
          ),
        );
  }
}