part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


class SearchWordEvent extends SearchEvent{
  final String searchValue;
  SearchWordEvent({required this.searchValue});


}

class SearchScreenInitialEvent extends SearchEvent{

}
class CarStyleFilterEvent extends SearchEvent{

  final List<String> filterData;

  CarStyleFilterEvent({required this.filterData});

}

class CarBrandFilterEvent extends SearchEvent{

  final List<String> filterData;

  CarBrandFilterEvent({required this.filterData});

}