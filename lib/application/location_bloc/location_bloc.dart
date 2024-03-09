import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:urbandrive/domain/location_repo.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepo locationrepo;
  LocationBloc(this.locationrepo) : super(LocationInitialState()) {
    on<LocationLoadingEvent>(locationLoading);
    on<LocationLoadedEvent>(locationloaded);
  //  on<GetLocationEvent>(getLocation, transformer: debouncing);
  }

  FutureOr<void> locationLoading(
      LocationLoadingEvent event, Emitter<LocationState> emit) {
    print("loading...");
  }

  FutureOr<void> locationloaded(
      LocationLoadedEvent event, Emitter<LocationState> emit) async {
    final suggestionlist = await locationrepo.getsuggestion(event.location);
    print("listed values are $suggestionlist");
    emit(LocationLoadedState(locationList: suggestionlist!));
  }

  // FutureOr<void> getLocation(
  //     GetLocationEvent event, Emitter<LocationState> emit) {
  //   try {
  //     emit(LocationLoadedState(pickedLocation: event.pickedLocation));
  //   } catch (e) {
  //     print("error is getlocation of ${e.toString()}");
  //   }
  // }

  Stream<GetLocationEvent> debouncing(
      Stream<GetLocationEvent> events, EventMapper<GetLocationEvent> mapper) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .switchMap(mapper);
  }
}
