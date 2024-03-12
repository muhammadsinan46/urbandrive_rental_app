part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationLoadingEvent extends LocationEvent{}
class PickupLocationLoadedEvent extends LocationEvent{

  final String pickuplocation;
  const PickupLocationLoadedEvent({required this.pickuplocation});


}


