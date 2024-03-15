part of 'car_booking_bloc.dart';

sealed class CarBookingEvent extends Equatable {
  const CarBookingEvent();

  @override
  List<Object> get props => [];
}

class CarDataLaodingEvent extends CarBookingEvent{}
class CardDataLoadedEvent extends CarBookingEvent{

  final String? modelId ;

  const CardDataLoadedEvent({ required this.modelId});
}


class CarBookingLoadedEvent extends CarBookingEvent{
 final String updateStatus;
 final String bookingId;
 CarBookingLoadedEvent({required this.updateStatus, required this.bookingId});

}

class CarBookingLogEvent extends CarBookingEvent{

  final String userId;

  CarBookingLogEvent({required this.userId});
}