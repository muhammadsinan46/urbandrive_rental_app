part of 'booking_confirm_bloc.dart';

class BookingConfirmState extends Equatable {
  const BookingConfirmState();

  @override
  List<Object> get props => [];
}

final class BookingConfirmInitialState extends BookingConfirmState {}

final class BookingConfirmLoadedState extends BookingConfirmState {
  final List<BookingModel> bookingdataList;
  BookingConfirmLoadedState({required this.bookingdataList});
}
