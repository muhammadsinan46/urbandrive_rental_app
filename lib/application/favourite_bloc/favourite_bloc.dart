import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/infrastructure/favourite_model/fav_model.dart';
import 'package:urbandrive/domain/repository/favourite_repo/favourite_repo.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {

  FavouriteRepo favRepo;
  FavouriteBloc(this.favRepo) : super(FavouriteState()) {

    on<FetchFavouriteEvent>(fetchFavourite);

    on<AddFavouriteEvent>(addFavtoList);

    on<RemoveFavouriteEvent>(removeFavourite);

  }

  FutureOr<void> fetchFavourite(FetchFavouriteEvent event, Emitter<FavouriteState> emit)async {

    final favList = await favRepo.getFavourite();

    emit(FavouriteLoadedState(favlist: favList));
  }

  FutureOr<void> addFavtoList(AddFavouriteEvent event, Emitter<FavouriteState> emit)async {

    await favRepo.addFavourite(event.favModel, );
      
    Future.delayed(Duration(seconds: 1));

          final favList = await favRepo.getFavourite();
    emit(FavouriteLoadedState(favlist: favList));


  }

  FutureOr<void> removeFavourite(RemoveFavouriteEvent event, Emitter<FavouriteState> emit) async{

    await favRepo.removeFavourite(event.favId);

    final favList = await favRepo.getFavourite();

    emit(FavouriteLoadedState(favlist: favList));


  }
}
