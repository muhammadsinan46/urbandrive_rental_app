import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/domain/repository/car_data_repo/cardata_repo.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';

part 'specific_category_list_event.dart';
part 'specific_category_list_state.dart';

class SpecificCategoryBloc extends Bloc<SpecificCategoryEvent, SpecificCategoryState> {

  final CardataRepo cardata;
  SpecificCategoryBloc(this.cardata) : super(SpecificCategoryState()) {

    on<SpecificCategoryLoadedEvent>(getModelList);
 
  }

  FutureOr<void> getModelList(SpecificCategoryLoadedEvent event, Emitter<SpecificCategoryState> emit)async {
    emit(SpecificCategoryInitialState());

    final getspecificCateList = await cardata.getSpecificCategoryList(event.carCategory!);


  emit(SpecificCategoryLoadedState(specificCateList: getspecificCateList));
    
  }
}
