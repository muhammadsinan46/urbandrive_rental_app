part of 'favourite_bloc.dart';

 class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}



class FetchFavouriteEvent extends FavouriteEvent{
  
}

class AddFavouriteEvent extends FavouriteEvent{

  final CarModels favModel;
 

  AddFavouriteEvent({required this.favModel});


}


class RemoveFavouriteEvent extends FavouriteEvent{

  final String  favId;
  RemoveFavouriteEvent({required this.favId});

}