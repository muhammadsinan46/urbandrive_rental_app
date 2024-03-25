import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:urbandrive/domain/location_repo.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepo locationrepo;
  LocationBloc(this.locationrepo) : super(LocationInitialState()) {
    on<LocationLoadingEvent>(locationLoading);
    on<PickupLocationLoadedEvent>(pickuplocationloaded);


  }

  FutureOr<void> locationLoading(
      LocationLoadingEvent event, Emitter<LocationState> emit) {
    print("loading...");
  }

  FutureOr<void> pickuplocationloaded(
      PickupLocationLoadedEvent event, Emitter<LocationState> emit) async {
    final suggestionlist = await locationrepo.getsuggestion(event.pickuplocation);
   
    emit(PickUpLocationLoadedState(pickuplocation: suggestionlist!));
  }





}
