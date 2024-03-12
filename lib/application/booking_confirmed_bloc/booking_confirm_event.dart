part of 'booking_confirm_bloc.dart';

 class BookingConfirmEvent extends Equatable {
  const BookingConfirmEvent();

  @override
  List<Object> get props => [];
}
class BookingConfirmLoadingEvent extends BookingConfirmEvent{}
class BookingConfirmLoadedEvent extends BookingConfirmEvent{

 final String? userId;
 const BookingConfirmLoadedEvent({required this.userId});
}