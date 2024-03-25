import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/presentation/booking/data_sources/fav_model.dart';
import 'package:urbandrive/presentation/booking/domain/favourite_repo.dart';

part 'favaourite_event.dart';
part 'favaourite_state.dart';

class FavaouriteBloc extends Bloc<FavaouriteEvent, FavaouriteState> {
  FavouriteRepo favrepo;
  FavaouriteBloc(this.favrepo) : super(FavaouriteState()) {
    on<AddFavouriteEvent>(addFavourite);
    on<RemoveFavouriteEvent>(removeFavourite);
  }

  FutureOr<void> addFavourite(
      AddFavouriteEvent event, Emitter<FavaouriteState> emit) async {
    await favrepo.addFavourte(event.carmodel);


      final favList = await favrepo.getFavourite();

      emit(FavaouriteLoadedState(carmodelList: favList));
  
  }

  FutureOr<void> removeFavourite(
      RemoveFavouriteEvent event, Emitter<FavaouriteState> emit)async {

        await favrepo.removeFavourite(event.favId);

        final favList = await favrepo.getFavourite();

        emit(FavaouriteLoadedState(carmodelList: favList));




      }
}
