import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upcoming_booking_event.dart';
part 'upcoming_booking_state.dart';

class UpcomingBookingBloc extends Bloc<UpcomingBookingEvent, UpcomingBookingState> {
  UpcomingBookingBloc() : super(UpcomingBookingInitial()) {
    on<UpcomingBookingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
