import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavChageState(index: 0)) {
    on<BottomNavEvent>((event, emit) {
        if(event is BottomNavChageEvent){
          emit(BottomNavChageState(index: event.index));
        }
    });
  }
}
