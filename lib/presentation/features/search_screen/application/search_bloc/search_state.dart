part of 'search_bloc.dart';

 class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}


final class SearchInitialState extends SearchState {

 final List<CarModels> allModelList;
  SearchInitialState({required this.allModelList});
  
  
}

final class SearchLoadedState extends SearchState {
  final List<CarModels> searchedList;
  final List<CarModels>modelList;

  SearchLoadedState({required this.searchedList, required this.modelList});

  List<Object> get props =>[searchedList];

}


final class FilterDataLoadedState extends SearchState{
  final List<CarModels> filteredCarList;
  FilterDataLoadedState({required this.filteredCarList});

  List<Object> get props =>[filteredCarList];
}
