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