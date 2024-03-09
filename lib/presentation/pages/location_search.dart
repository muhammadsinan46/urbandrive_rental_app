import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbandrive/application/location_bloc/location_bloc.dart';

class LocationSearchScreen extends StatelessWidget {
   LocationSearchScreen({super.key,});


  TextEditingController searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [

          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width-50,
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return TextFormField(
                       onChanged: (value) {
                          context.read<LocationBloc>().add(LocationLoadedEvent(location: value));
            
                          
                        },
                              controller: searchController,
                            decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          
                                hintText: "City or Address",
                              label: Text("Search")),
                          
                            );
                },
              ),
            ),
          ),

          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {

              if(state is LocationInitialState){
                return Center(child: Container(),);
              }else if( state is LocationLoadedState){
                
              return Container(height: MediaQuery.sizeOf(context).height-10,
                    width:MediaQuery.sizeOf(context).height ,
                    child: ListView.builder(
                      itemCount: state.locationList.length ,
                      itemBuilder:(context, index) {
                      return  ListTile(
                      onTap: () {
                        
                      },
                  
                        title:Text('${ state.locationList[index]['description']}'),);
                    }, ),
                    
                    );
              }
              return Container();
            },
          )
            
        
        ],),
      ),
    );
  }
}