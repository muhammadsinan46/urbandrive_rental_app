// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:urbandrive/application/dropoff_location_bloc/dropoff_location_bloc.dart';
import 'package:urbandrive/application/pickup_location_bloc/location_bloc.dart';

class LocationSearchScreen extends StatelessWidget {
  LocationSearchScreen({super.key, required this.isSearch});

  bool isSearch;
  TextEditingController pickupsearchController = TextEditingController();
  TextEditingController dropoffsearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width - 50,
                child: isSearch == true
                    ? BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) {
                          return TextFormField(
                            onChanged: (value) {
                              context.read<LocationBloc>().add(
                                  PickupLocationLoadedEvent(
                                      pickuplocation: value));
                            },
                            controller: pickupsearchController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "City or Address",
                                //label: Text("Search")
                                ),
                          );
                        },
                      )
                    : BlocBuilder<DropoffLocationBloc, DropoffLocationState>(
                        builder: (context, state) {
                          return TextFormField(
                            onChanged: (value) {
                              context.read<DropoffLocationBloc>().add(
                                  DropoffLoadedEvent(dropofflocation: value));
                            },
                            controller: dropoffsearchController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "City or Address",
                                label: Text("Search")),
                          );
                        },
                      ),
              ),
            ),
            isSearch == true
                ? BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, state) {
                      if (state is LocationInitialState) {
                        return Center(
                          child: Container(),
                        );
                      } else if (state is PickUpLocationLoadedState) {
                        return Container(
                          height: MediaQuery.sizeOf(context).height - 10,
                          width: MediaQuery.sizeOf(context).height,
                          child: ListView.builder(
                            itemCount: state.pickuplocation.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.pop(
                                      context,
                                      state.pickuplocation[index]
                                          ['description']);
                                },
                                title: Text(
                                    '${state.pickuplocation[index]['description']}'),
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  )
                : BlocBuilder<DropoffLocationBloc, DropoffLocationState>(
                    builder: (context, state) {
                      if (state is DropOffLocationInitialState) {
                        return Center(
                          child: Container(),
                        );
                      } else if (state is DropOffLocationLoadedState) {
                        return Container(
                          height: MediaQuery.sizeOf(context).height - 10,
                          width: MediaQuery.sizeOf(context).height,
                          child: ListView.builder(
                            itemCount: state.dropoffLocation.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.pop(
                                      context,
                                      state.dropoffLocation[index]
                                          ['description']);
                                },
                                title: Text(
                                    '${state.dropoffLocation[index]['description']}'),
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
