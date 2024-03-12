part of 'dropoff_location_bloc.dart';

sealed class DropoffLocationState extends Equatable {
  const DropoffLocationState();
  
  @override
  List<Object> get props => [];
}

class DropOffLocationInitialState extends  DropoffLocationState {}
class DropOffLocationLoadedState extends DropoffLocationState{

  final List<dynamic>dropoffLocation;
  DropOffLocationLoadedState({required this.dropoffLocation});


  @override
  List<Object> get props =>[dropoffLocation];



}
