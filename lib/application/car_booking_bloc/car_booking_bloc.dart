import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/domain/cardata_repo.dart';

part 'car_booking_event.dart';
part 'car_booking_state.dart';

class CarBookingBloc extends Bloc<CarBookingEvent, CarBookingState> {
  final CardataRepo carRepo;
  CarBookingBloc(this.carRepo) : super(CarDataLoadingState()) {
  on<CarDataLaodingEvent>(carDataLoading);
  on<CardDataLoadedEvent>(carDataLoaded);
  }

  FutureOr<void> carDataLoading(CarDataLaodingEvent event, Emitter<CarBookingState> emit) {

    print("loading...");
  }

  FutureOr<void> carDataLoaded(CardDataLoadedEvent event, Emitter<CarBookingState> emit)async {

    final carModelData =await carRepo.getSpecificModel(event.modelId!);

    emit(CarDataLoadedState(carModel: carModelData));
  }
}
