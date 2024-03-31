import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/application/search_bloc/search_bloc.dart';
import 'package:urbandrive/presentation/search_screen/pages/filter_screen.dart';
import 'package:urbandrive/presentation/search_screen/widgets/search_car_card.dart';
import 'package:urbandrive/presentation/search_screen/widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.allModelslist,
  required this.isLocation, required this.userId
  
  });

  final List<CarModels> allModelslist;
  final bool isLocation;
  final String userId;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _searchController = TextEditingController();

   List<CarModels> carModelList=[];

   List<CarModels> carSearchList=[];

   

  @override
  Widget build(BuildContext context) {
    carSearchList.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text("search"),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SearchField(searchController: _searchController),
              SizedBox(
                width: 5,
              ),
            CarFilterButton()
         
           
             
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 10),
            height: 30,
      
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Search Results", style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width - 10,
            height: MediaQuery.sizeOf(context).height-220,
            child: BlocBuilder<SearchBloc, SearchState>(
      
      
              builder: (context, state) {
                  print("state is ${state.runtimeType}");
           
               if(state is SearchLoadedState){
      
                  carSearchList =state.searchedList;
                  carModelList = state.modelList;
            
                  return carSearchList.length!=0? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  itemCount: state.searchedList.length,
                  itemBuilder: (context, index) {
                    return SearchCarCard(list:carSearchList,index: index,userId: widget.userId,isLocation: widget.isLocation,  );
                  },
                ):ListView.builder(
                  itemCount:carModelList.length ,
                  itemBuilder: (context, index) {
      
                  return SearchCarCard(list: carModelList, index: index,userId: widget.userId,isLocation: widget.isLocation, );
                  
                },);
      
                }else if(state is FilterDataLoadedState){
                    final carstylelList = state.filteredCarList;
                  ;
                    return ListView.builder(
                  itemCount: carstylelList.length ,
                  itemBuilder: (context, index) {
      
                  return SearchCarCard(list:carstylelList, index: index,userId: widget.userId,isLocation: widget.isLocation, );
                  
                },);
                
                }
                return ListView.builder(
                  itemCount: widget.allModelslist.length ,
                  itemBuilder: (context, index) {
      
                  return SearchCarCard(list: widget.allModelslist, index: index,userId: widget.userId,isLocation: widget.isLocation, );
                  
                },);
                
              
              },
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }

  
}
