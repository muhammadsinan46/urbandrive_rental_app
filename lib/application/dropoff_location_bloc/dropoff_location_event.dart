part of 'dropoff_location_bloc.dart';

sealed class DropoffLocationEvent extends Equatable {
  const DropoffLocationEvent();

  @override
  List<Object> get props => [];
}
class DropoffLoadingEvent extends DropoffLocationEvent{}
class DropoffLoadedEvent extends DropoffLocationEvent{

  final String dropofflocation;
   const DropoffLoadedEvent({required this.dropofflocation});


}