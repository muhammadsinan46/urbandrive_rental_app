part of 'filter_card_bloc.dart';

sealed class FilterCardState extends Equatable {
  const FilterCardState();
  
  @override
  List<Object> get props => [];
}

final class FilterCardInitial extends FilterCardState {}
