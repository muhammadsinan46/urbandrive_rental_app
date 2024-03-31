// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/favourite_bloc/favourite_bloc.dart';
import 'package:urbandrive/application/homescreen_bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/infrastructure/brand_model/brand_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/infrastructure/category_model/category_model.dart';
import 'package:urbandrive/infrastructure/favourite_model/fav_model.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';
import 'package:urbandrive/presentation/search_screen/pages/search_screen.dart';
import 'package:urbandrive/presentation/home_screen/pages/home_screen_shimmer.dart';
import 'package:urbandrive/presentation/profile_screen/pages/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    // this.isLocation
  });

  String? userLocation;
  bool? isLocation;
  List<BrandModel> brandlist = [];
  List<CategoryModel> categorylist = [];
  List<CarModels> carmodelslist = [];

  String? userId;

  //UserModel userdata;
  // final UserModel user;

  @override
  Widget build(BuildContext context) {
    context.read<UsersBloc>().add(GetUserEvent());
    context.read<HomescreenBloc>().add(HomescreenLoadedEvent());
    double sWidth = MediaQuery.sizeOf(context).width;
    double sHeight = MediaQuery.sizeOf(context).height;

    // List<Widget> carousalitems = [
    //   CarousalFirst(sWidth: sWidth),
    //   // CarousalFirst(sWidth: sWidth),
    //   // CarousalFirst(sWidth: sWidth),
    //   // CarousalFirst(sWidth: sWidth),
    // ];
    return Scaffold(body: BlocBuilder<HomescreenBloc, HomescreenState>(
      builder: (context, state) {
        if (state is HomescreenLoadingState) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.grey.shade100,
                  //  titleSpacing: BorderSide.strokeAlignCenter,
                  elevation: 0,
                  pinned: true,
                  //expandedHeight: 10,
                  floating: false,
                  leading: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person),
                    ),
                  ),

                  actions: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,

                        ///  Icon(Icons.search),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],

                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      return FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                      );
                    },
                  ),
                ),
              ];
            },
            body: HomeScreenShimmer(
                sWidth: sWidth,
                brandlist: brandlist,
                sHeight: sHeight,
                carmodelslist: carmodelslist),
          );
        } else if (state is HomescreenLoadedState) {
          brandlist = state.brandList;
          categorylist = state.categorylist;
          carmodelslist = state.carmodelsList;

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
                                  itemCount: brandlist.length,
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
                                              imageUrl: brandlist[index].logo!,
                                              fit: BoxFit.cover,
                                            ),
                                            radius: 35,
                                          ),
                                          Text(
                                            brandlist[index].name!,
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
                      SliverToBoxAdapter(child: CarousalFirst(sWidth: sWidth)
                          //  CarouselSlider(
                          //     items: carousalitems,
                          //     options: CarouselOptions(
                          //       autoPlay: false,
                          //       aspectRatio: 2.0,
                          //       // enlargeCenterPage: true
                          //     )),
                          ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                "Categories",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              // trailing: Text(
                              //   "View All",
                              //   style: TextStyle(fontSize: 15),
                              // ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8, right: 8),
                              height: 150,
                              width: sWidth,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categorylist.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 12),
                                    height: 120,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      categorylist[index]
                                                          .image!))),
                                          height: 100,
                                          //  width: 150,
                                        ),
                                        Text(categorylist[index].name!)
                                      ],
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
                              // primary: false,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.5,
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 5),
                              itemCount: carmodelslist.length,
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
                                            carId: carmodelslist[index].id,
                                            userId: userId!,
                                            //  userLocation: userLocation!,
                                          ),
                                        ));
                                  },
                                  child: ShowCarDetailsCard(
                                      carmodelslist: carmodelslist,
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
                  brandlist: brandlist,
                  sHeight: sHeight,
                  carmodelslist: carmodelslist);
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
      //  shape: ContinuousRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(50),
      //       bottomRight: Radius.circular(50))),
      backgroundColor: Colors.blue,
      //  titleSpacing: BorderSide.strokeAlignCenter,
      elevation: 0,
      pinned: true,
      //expandedHeight: 10,

      leading: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowProfileScreen()));
        },
        child: Container(
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

      // flexibleSpace: LayoutBuilder(
      //   builder: (context, constraints) {
      //     return FlexibleSpaceBar(
      //       collapseMode: CollapseMode.parallax,
      //       //background: ,
      //     );
      //   },
      // ),
    );
  }

  SliverAppBar sliverAppBar2(
      context, double width, bool isLocation, String userId) {
    return SliverAppBar(
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
                              allModelslist: carmodelslist,
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

class ShowCarDetailsCard extends StatelessWidget {
  ShowCarDetailsCard(
      {super.key, required this.carmodelslist, required this.index});
  final index;
  final List<CarModels> carmodelslist;
  List<FavouriteModel> favList = [];

  @override
  Widget build(BuildContext context) {
    context.read<FavouriteBloc>().add(FetchFavouriteEvent());
    return Container(
      decoration: BoxDecoration(),
      child: Card(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 2,
                  height: 170,
                  child: CachedNetworkImage(
                    imageUrl: carmodelslist[index].images.last,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${carmodelslist[index].brand!} ${carmodelslist[index].model}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "₹ ${carmodelslist[index].price!}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "9am -9pm",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                            child: Text(
                          carmodelslist[index].category!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                        height: 30,
                        width: 80,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text("${carmodelslist[index].seats!} seats",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        height: 30,
                        width: 80,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(carmodelslist[index].transmit!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        height: 30,
                        width: 80,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 2,
              top: 2,
              child: BlocBuilder<FavouriteBloc, FavouriteState>(
                builder: (context, state) {
                  Color iconColor = Colors.black;

                  if (state is FavouriteLoadedState) {
                    favList = state.favlist;
                    if (index >= 0 && index < state.favlist.length) {
               
                      if (favList[index].favId == carmodelslist[index].id) {
                        iconColor = Colors.red;
                      }
                    }
                  }
                  return CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            //   if(favList[index].favId ==carmodelslist[index].id){
                            //  // context.read<FavouriteBloc>().add(RemoveFavouriteEvent(favId: favList[index].favId));

                            //  print("exist");
                            //   }else{
                            //     print("please add");
                            //   }
                            context.read<FavouriteBloc>().add(AddFavouriteEvent(
                                  favModel: carmodelslist[index],
                                ));
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data")));
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: iconColor,
                          )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CarousalFirst extends StatelessWidget {
  const CarousalFirst({
    super.key,
    required this.sWidth,
  });

  final double sWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      //  color: Colors.black26,
      child: Container(
        width: sWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'lib/assets/images/carousal1.jpg',
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10)),
        height: 250,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                // margin: EdgeInsets.only(left: 50),
                height: 150,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(176, 255, 255, 255),
                ),

                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                children: [
                              TextSpan(text: "Flat "),
                              TextSpan(
                                  text: "25% OFF",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " on"),
                              TextSpan(text: "\nyour first ride"),
                            ])),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      height: 40,
                      width: 140,
                      child: GestureDetector(
                        onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => CarBookingScreen(carId: carId, userId: userId, locationStatus: locationStatus),))
                        },
                        child: Text(
                          "BOOK NOW",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
