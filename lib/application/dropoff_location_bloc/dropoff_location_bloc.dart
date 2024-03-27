import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/domain/repository/location_repo/location_repo.dart';

part 'dropoff_location_event.dart';
part 'dropoff_location_state.dart';

class DropoffLocationBloc
    extends Bloc<DropoffLocationEvent, DropoffLocationState> {
  final LocationRepo locationrepo;
  DropoffLocationBloc(this.locationrepo)
      : super(DropOffLocationInitialState()) {
    on<DropoffLoadingEvent>(dropoffloading);
    on<DropoffLoadedEvent>(dropoffloaded);
  }

  FutureOr<void> dropoffloading(
      DropoffLoadingEvent event, Emitter<DropoffLocationState> emit) {
    print("loading....");
  }

  FutureOr<void> dropoffloaded(
      DropoffLoadedEvent event, Emitter<DropoffLocationState> emit) async {
    final dropofflist = await locationrepo.getsuggestion(event.dropofflocation);

    emit(DropOffLocationLoadedState(dropoffLocation: dropofflist!));
  }
}
