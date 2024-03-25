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

class UpcomingCarBookingLogEvent extends CarBookingEvent{

  final String userId;

  UpcomingCarBookingLogEvent({required this.userId});
}

class HistoryCarBookingLogEvent extends CarBookingEvent{
  final String userId;
  HistoryCarBookingLogEvent({required this.userId});

}