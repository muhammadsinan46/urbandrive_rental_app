import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:urbandrive/infrastructure/brand_model/brand_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/domain/repository/car_data_repo/cardata_repo.dart';
import 'package:urbandrive/infrastructure/category_model/category_model.dart';

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
   
  }

  FutureOr<void> homescreenloaded(
      HomescreenLoadedEvent event, Emitter<HomescreenState> emit) async {
    try {
      final brandModelList = await cardata.getBranddata();
      final categorylist = await cardata.getCategoryData();
      final carmodellist =await cardata.getCarModels();
      emit(HomescreenLoadedState(brandModelList: brandModelList, categoryList: categorylist, carModelsList:carmodellist ));
    } catch (e) {
      print(e.toString());
    }
  }
}
