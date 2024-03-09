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