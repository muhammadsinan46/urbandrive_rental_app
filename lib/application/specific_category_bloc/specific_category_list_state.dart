part of 'specific_category_list_bloc.dart';

 class SpecificCategoryState extends Equatable {
  const SpecificCategoryState();
  
  @override
  List<Object> get props => [];
}

final class SpecificCategoryInitialState extends SpecificCategoryState {}
final class SpecificCategoryLoadedState extends SpecificCategoryState{

 final  List<CarModels > specificCateList ;

SpecificCategoryLoadedState({required this.specificCateList});

 List<Object> get props =>[specificCateList];


}
