import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_card_event.dart';
part 'filter_card_state.dart';

class FilterCardBloc extends Bloc<FilterCardEvent, FilterCardState> {
  FilterCardBloc() : super(FilterCardInitial()) {
    on<FilterCardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
