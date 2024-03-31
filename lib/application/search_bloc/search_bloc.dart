import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/presentation/search_screen/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  
  SearchRepo searchRepo;
  SearchBloc(
    this.searchRepo
    ) : super(SearchState()) {
    on<SearchScreenInitialEvent>(allModelsLoading);
    on<SearchWordEvent>(onSearchCars);
    on<CarStyleFilterEvent>(onCarStyleFilter);
    on<PriceRangeFilterEvent>(priceRangeFilter);
    on<PriceSortFilterEvent>(priceSorting);

  }


  FutureOr<void> onSearchCars(
      SearchWordEvent event, Emitter<SearchState> emit) async {
        final wholeList = await searchRepo.getallModels();
       emit(SearchInitialState(allModelList: wholeList));

        final SearchList = await searchRepo.getSerachCars(event.searchValue);
      emit(SearchLoadedState(searchedList: SearchList, modelList:wholeList ));
    // try {
    //   final searchDetails = await searchRepo.getSerachCars(event.serachValue);
    //   emit(SearchLoadedState(searchedList: searchDetails));
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  FutureOr<void> allModelsLoading(SearchScreenInitialEvent event, Emitter<SearchState> emit)async {

    final wholeList =await searchRepo.getallModels();
    emit(SearchInitialState(allModelList: wholeList));
  }

  FutureOr<void> onCarStyleFilter(CarStyleFilterEvent event, Emitter<SearchState> emit)async {


final carStyleList = await searchRepo.getCarStyleFilterData(event.filterData);


emit(FilterDataLoadedState(filteredCarList: carStyleList));

  }



  FutureOr<void> priceRangeFilter(PriceRangeFilterEvent event, Emitter<SearchState> emit)async {

    final carPriceList = await searchRepo.getPriceRangeFilter(event.priceRange);

    emit(FilterDataLoadedState(filteredCarList: carPriceList));

  }

  FutureOr<void> priceSorting(PriceSortFilterEvent event, Emitter<SearchState> emit)async {

    final sortedList = await searchRepo.getPriceSortFilter(event.radioValue);

    emit(FilterDataLoadedState(filteredCarList: sortedList));
  }
}
