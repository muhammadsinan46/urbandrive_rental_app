part of 'car_booking_bloc.dart';

sealed class CarBookingState extends Equatable {
  const CarBookingState();

  @override
  List<Object> get props => [];
}

final class CarDataLoadingState extends CarBookingState {}

final class CarDataLoadedState extends CarBookingState {
  final List<CarModels> carModel;

  const CarDataLoadedState({required this.carModel});
}

class CarBookingLogState extends CarBookingState {
  final List<BookingModel> bookingdata;
  final List<BookingModel>bookingHistory;

  const CarBookingLogState({required this.bookingdata, required this.bookingHistory});

  List<Object> get props => [bookingdata, bookingHistory];
}
