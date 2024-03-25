import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:urbandrive/domain/brand_model.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/presentation/booking/domain/cardata_repo.dart';
import 'package:urbandrive/domain/category_model.dart';

part 'homescreen_bloc_event.dart';
part 'homescreen_bloc_state.dart';

class HomescreenBloc
    extends Bloc<HomescreenEvent, HomescreenState> {
  CardataRepo cardata;
  HomescreenBloc(this.cardata) : super(HomescreenLoadingState()) {
    on<HomescreenLoadingEvent>(homescreenloading);
    on<HomescreenLoadedEvent>(homescreenloaded);
  }

  FutureOr<void> homescreenloading(
      HomescreenLoadingEvent event, Emitter<HomescreenState> emit) {
    print("loading...");
  }

  FutureOr<void> homescreenloaded(
      HomescreenLoadedEvent event, Emitter<HomescreenState> emit) async {
    try {
      final brandlist = await cardata.getBranddata();
      final categorylist = await cardata.getCategoryData();
      final carmodellist =await cardata.getCarModels();
      emit(HomescreenLoadedState(brandList: brandlist, categorylist: categorylist, carmodelsList:carmodellist ));
    } catch (e) {
      print(e.toString());
    }
  }
}
