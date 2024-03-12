part of 'location_bloc.dart';

 class LocationState extends Equatable {
  const LocationState();
  
      List<Object> get props => [];
}

 class LocationInitialState extends LocationState {}
 class PickUpLocationLoadedState extends LocationState {

  final List<dynamic> pickuplocation ;
   //final String ? pickedLocation;

   PickUpLocationLoadedState({required this.pickuplocation});

@override
  List<Object> get props => [pickuplocation];
}
