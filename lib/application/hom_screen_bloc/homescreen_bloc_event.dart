part of 'homescreen_bloc_bloc.dart';

sealed class HomescreenEvent extends Equatable {
  const HomescreenEvent();

  @override
  List<Object> get props => [];
}


class HomescreenLoadingEvent extends HomescreenEvent{}
class HomescreenLoadedEvent extends HomescreenEvent{}