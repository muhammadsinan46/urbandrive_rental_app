part of 'favourite_bloc.dart';

 class FavouriteState extends Equatable {
  const FavouriteState();
  
  @override
  List<Object> get props => [];
}

final class FavouriteInitialState extends FavouriteState {}
final class FavouriteLoadedState extends FavouriteState {

  final List<FavouriteModel> favlist;

   FavouriteLoadedState({required this.favlist});

   List<Object> get props => [favlist];

}
