part of 'homescreen_bloc_bloc.dart';

 class HomescreenState extends Equatable {
  const HomescreenState();
  
  @override
  List<Object> get props => [];
}

final class HomescreenLoadingState extends HomescreenState {}
final class HomescreenLoadedState extends HomescreenState{

  final  List<BrandModel> brandList;
  final List<CategoryModel> categorylist;
  final List<CarModels> carmodelsList;
  HomescreenLoadedState({required this.brandList, required this.categorylist, required this.carmodelsList});

  List<Object> get props =>[brandList, categorylist,carmodelsList];


}
