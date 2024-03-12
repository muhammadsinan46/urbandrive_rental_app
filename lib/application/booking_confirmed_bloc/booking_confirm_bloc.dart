import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/domain/booking_model.dart';
import 'package:urbandrive/domain/booking_repo.dart';

part 'booking_confirm_event.dart';
part 'booking_confirm_state.dart';

class BookingConfirmBloc
    extends Bloc<BookingConfirmEvent, BookingConfirmState> {
  BookingRepo bookingRepo;
  BookingConfirmBloc(this.bookingRepo) : super(BookingConfirmInitialState()) {
    on<BookingConfirmLoadingEvent>(bookingdataLoading);
    on<BookingConfirmLoadedEvent>(bookingDataLoaded);
  }

  FutureOr<void> bookingdataLoading(
      BookingConfirmLoadingEvent event, Emitter<BookingConfirmState> emit) {
    print("loading....");
  }

  FutureOr<void> bookingDataLoaded(BookingConfirmLoadedEvent event,
      Emitter<BookingConfirmState> emit) async {

        try{
              final bookingdataList = await bookingRepo.getBookingData(event.userId!);

    emit(BookingConfirmLoadedState(bookingdataList: bookingdataList));

        }catch(e){
            print("error to loading bookin confirmed data ${e.toString()}");
        }

  }
}
