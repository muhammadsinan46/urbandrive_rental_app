part of 'homescreen_bloc_bloc.dart';

 class HomescreenState extends Equatable {
  const HomescreenState();
  
  @override
  List<Object> get props => [];
}

final class HomescreenLoadingState extends HomescreenState {}
final class HomescreenLoadedState extends HomescreenState{

  final  List<BrandModel> brandModelList;
  final List<CategoryModel> categoryList;
  final List<CarModels> carModelsList;
  HomescreenLoadedState({required this.brandModelList, required this.categoryList, required this.carModelsList});

  List<Object> get props =>[brandModelList, categoryList,carModelsList];


}
