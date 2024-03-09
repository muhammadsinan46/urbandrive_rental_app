part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
      List<Object> get props => [];
}

 class LocationInitialState extends LocationState {}
 class LocationLoadedState extends LocationState {

  final List<dynamic> locationList ;
   //final String ? pickedLocation;

   LocationLoadedState({required this.locationList});

  List<Object> get props => [locationList];
}
