import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:urbandrive/application/favourite_bloc/favourite_bloc.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';
import 'package:urbandrive/presentation/favourite_screen/widgets.dart/favourite_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavouriteBloc>().add(FetchFavouriteEvent());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Favourite Cars"),
        ),
        body: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            if (state is FavouriteLoadedState) {
              final favList = state.favlist;
              return favList.length == 0
                  ? Center(
                      child: Text("Looks Empty . No Favourite Cars found"),
                    )
                  : ListView.builder(
                      itemCount: favList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CarBookingScreen(carId: favList[index].carmodel['id'], userId: favList[index].userId, locationStatus: true, isEdit: false),));
                          },
                          child: FavouriteCard(
                            favList: favList,
                            idx: index,
                          ),
                        );
                      },
                    );
            }

            return Container();
          },
        ));
  }
}
