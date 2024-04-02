part of 'specific_category_list_bloc.dart';

sealed class SpecificCategoryEvent extends Equatable {
  const SpecificCategoryEvent();

  @override
  List<Object> get props => [];
}


class SpecificCategoryLoadedEvent extends SpecificCategoryEvent{

  final String? carCategory;

  SpecificCategoryLoadedEvent({required this.carCategory});


}