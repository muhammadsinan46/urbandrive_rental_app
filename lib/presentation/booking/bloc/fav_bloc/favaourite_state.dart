part of 'favaourite_bloc.dart';

 class FavaouriteState extends Equatable {
  const FavaouriteState();
  
  @override
  List<Object> get props => [];
}


final class FavaouriteLoadingState extends FavaouriteState {}
final class FavaouriteLoadedState extends FavaouriteState {

  final List<FavouriteModel> carmodelList;


  FavaouriteLoadedState({required this.carmodelList});

  List<Object> get props =>[ carmodelList];


}