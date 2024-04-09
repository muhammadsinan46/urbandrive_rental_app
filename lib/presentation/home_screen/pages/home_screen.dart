// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:urbandrive/application/homescreen_bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/infrastructure/brand_model/brand_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/infrastructure/category_model/category_model.dart';

import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';
import 'package:urbandrive/presentation/home_screen/widgets/appbar_shimmer.dart';
import 'package:urbandrive/presentation/home_screen/widgets/homescreen_carousal.dart';
import 'package:urbandrive/presentation/home_screen/widgets/specific_category_list.dart';
import 'package:urbandrive/presentation/home_screen/widgets/show_car_detail_card.dart';
import 'package:urbandrive/presentation/search_screen/pages/search_screen.dart';
import 'package:urbandrive/presentation/home_screen/pages/home_screen_shimmer.dart';
import 'package:urbandrive/presentation/profile_screen/pages/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  String? userLocation;
  bool? isLocation;
  List<BrandModel> brandModelList = [];
  List<CategoryModel> categoryList = [];
  List<CarModels> carModelsList = [];

  String? userId;

  @override
  Widget build(BuildContext context) {
    context.read<UsersBloc>().add(GetUserEvent());
    context.read<HomescreenBloc>().add(HomescreenLoadedEvent());
    double sWidth = MediaQuery.sizeOf(context).width;
    double sHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(body: BlocBuilder<HomescreenBloc, HomescreenState>(
      builder: (context, state) {
        if (state is HomescreenLoadingState) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                AppbarLoading(),
              ];
            },
            body: HomeScreenShimmer(
                sWidth: sWidth, sHeight: sHeight, carModelsList: carModelsList),
          );
        } else if (state is HomescreenLoadedState) {
          brandModelList = state.brandModelList;
          categoryList = state.categoryList;
          carModelsList = state.carModelsList;

          return BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              if (state is UsersLoadedState) {
                userLocation = state.users.location;
                userId = state.users.id;
                isLocation = state.users.locationStatus;
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppbarLoaded(context, state),
                      sliverAppBar2(context, sWidth, isLocation!, userId!)
                    ];
                  },
                  body: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          child: Column(
                            children: [
                              ListTile(
                                trailing: Icon(Icons.arrow_forward_ios),
                                leading: Text(
                                  "Brands",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(12),
                                height: 100,
                                width: sWidth,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: brandModelList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                35, 209, 232, 251),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  brandModelList[index].logo!,
                                              fit: BoxFit.cover,
                                            ),
                                            radius: 35,
                                          ),
                                          Text(
                                            brandModelList[index].name!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: CarousalFirst(
                        sWidth: sWidth,
                        carModelsList: carModelsList,
                        userId: userId,
                      )),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ListTile(
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Text(
                                "Categories",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8, right: 8),
                              height: 150,
                              width: sWidth,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 12),
                                    height: 120,
                                    width: 150,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CarModelListScreen(
                                                category:
                                                    categoryList[index].name,
                                                userId: userId,
                                              ),
                                            ));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        categoryList[index]
                                                            .image!))),
                                            height: 100,
                                          ),
                                          Text(categoryList[index].name!)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                "Available Cars",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.5,
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 5),
                              itemCount: carModelsList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CarBookingScreen(
                                            isEdit: false,
                                            locationStatus: isLocation!,
                                            carId: carModelsList[index].id,
                                            userId: userId!,
                                          ),
                                        ));
                                  },
                                  child: ShowCarDetailsCard(
                                      carModelsList: carModelsList,
                                      index: index),
                                );
                              },
                            ),
                            Container(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return HomeScreenShimmer(
                  sWidth: sWidth,
                  sHeight: sHeight,
                  carModelsList: carModelsList);
            },
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }

  SliverAppBar SliverAppbarLoaded(
      BuildContext context, UsersLoadedState state) {
    return SliverAppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      pinned: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ShowProfileScreen()));
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
        ),
      ),
      title: ListTile(
        subtitle: Text(
          state.users.name,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        title: Text(
          "Hi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                child: ImageIcon(
                  AssetImage('lib/assets/icons/notification.png'),
                  color: Colors.blue,
                )

                ///  Icon(Icons.search),
                ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  SliverAppBar sliverAppBar2(
      context, double width, bool isLocation, String userId) {
    return SliverAppBar(
      collapsedHeight: 80,
      expandedHeight: 80,
      shadowColor: Colors.black,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      backgroundColor: Colors.blue,
      pinned: true,
      flexibleSpace: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 12),
                  width: 200,
                  height: 35,
                  child: userLocation == null
                      ? Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Color.fromARGB(96, 255, 255, 255),
                            ),
                            title: Text("Location?",
                                style: TextStyle(
                                  color: Color.fromARGB(96, 255, 255, 255),
                                  fontSize: 16,
                                )),
                          ),
                        )
                      : Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            title: Text(
                              "${userLocation}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ))),
          Container(
            margin: EdgeInsets.only(bottom: 5, left: 10, top: 10, right: 10),
            height: 50,
            width: width - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              isLocation: isLocation,
                              userId: userId,
                              allModelslist: carModelsList,
                            )));
              },
              leading: Icon(Icons.search),
              title: Text(
                "Search for your car",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
