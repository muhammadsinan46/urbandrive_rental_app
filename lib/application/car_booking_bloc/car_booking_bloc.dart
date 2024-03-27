import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/domain/repository/car_data_repo/cardata_repo.dart';

part 'car_booking_event.dart';
part 'car_booking_state.dart';

class CarBookingBloc extends Bloc<CarBookingEvent, CarBookingState> {
  final CardataRepo carRepo;
  CarBookingBloc(this.carRepo) : super(CarBookingState()) {
  on<CarDataLaodingEvent>(carDataLoading);
  on<CardDataLoadedEvent>(carDataLoaded);
  on<CarBookingLoadedEvent>(carbookingloading);
  on<UpcomingCarBookingLogEvent>(upcomingbookingLoading);
  on<HistoryCarBookingLogEvent>(histoyBookingLoading);
  }

  FutureOr<void> carDataLoading(CarDataLaodingEvent event, Emitter<CarBookingState> emit) {

    print("loading...");
  }

  FutureOr<void> carDataLoaded(CardDataLoadedEvent event, Emitter<CarBookingState> emit)async {

    final carModelData =await carRepo.getSpecificModel(event.modelId!);

    emit(CarDataLoadedState(carModel: carModelData));
  }

  FutureOr<void> carbookingloading(CarBookingLoadedEvent event, Emitter<CarBookingState> emit)async {
    try{

    await FirebaseFirestore.instance.collection('bookings').doc(event.bookingId).update({"payment-status":event.updateStatus});
    }catch (e){

      print("error occured ${e.toString()}");
    }


  }

  FutureOr<void> upcomingbookingLoading(UpcomingCarBookingLogEvent event, Emitter<CarBookingState> emit)async {
    final upcomingData = await carRepo.getUpcomingBookingData(event.userId);


    

    emit(UpcomingCarBookingLogState(bookingdata: upcomingData));
  }

  FutureOr<void> histoyBookingLoading(HistoryCarBookingLogEvent event, Emitter<CarBookingState> emit)async {

        final historyData = await carRepo.getBookingHistory(event.userId);

        emit(HistoryCarBookingState(bookingHistory: historyData));


  }
}
