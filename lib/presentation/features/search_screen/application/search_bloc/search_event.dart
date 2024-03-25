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
class FilterScreenLoadedEvent extends SearchEvent{

  final List<String> filterData;

  FilterScreenLoadedEvent({required this.filterData});

}