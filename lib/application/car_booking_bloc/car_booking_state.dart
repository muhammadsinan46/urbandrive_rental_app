part of 'car_booking_bloc.dart';

 class CarBookingState extends Equatable {
  const CarBookingState();

  @override
  List<Object> get props => [];
}

final class CarDataLoadingState extends CarBookingState {}

final class CarDataLoadedState extends CarBookingState {
  final List<CarModels> carModel;

  const CarDataLoadedState({required this.carModel});

  List<Object> get props =>[carModel];
}

class UpcomingCarBookingLogState extends CarBookingState {
  final List<BookingModel> bookingdata;
 

  const UpcomingCarBookingLogState({required this.bookingdata});

  List<Object> get props => [bookingdata];
}

class HistoryCarBookingState extends CarBookingState{
   final List<BookingModel>bookingHistory;

   HistoryCarBookingState({required this.bookingHistory});
    List<Object> get props => [ bookingHistory];

}
