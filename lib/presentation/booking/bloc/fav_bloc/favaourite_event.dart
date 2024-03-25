part of 'favaourite_bloc.dart';

 class FavaouriteEvent extends Equatable {
  const FavaouriteEvent();

  @override
  List<Object> get props => [];
}


class AddFavouriteEvent extends FavaouriteEvent{

final CarModels carmodel;

  AddFavouriteEvent({ required this.carmodel});

  List<Object> get props =>[carmodel];


}


class RemoveFavouriteEvent extends FavaouriteEvent{

final CarModels carmodel;
final String favId;

  RemoveFavouriteEvent({ required this.carmodel,required this.favId});
    List<Object> get props =>[carmodel, favId];


}

