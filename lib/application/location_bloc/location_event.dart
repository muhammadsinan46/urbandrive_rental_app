part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationLoadingEvent extends LocationEvent{}
class LocationLoadedEvent extends LocationEvent{

  final String location;
  const LocationLoadedEvent({required this.location});


}

class GetLocationEvent extends LocationEvent{
  String pickedLocation;

  GetLocationEvent({required this.pickedLocation});
  
}
