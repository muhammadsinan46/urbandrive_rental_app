// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:urbandrive/application/hom_screen_bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/brand_model.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/domain/category_model.dart';

import 'package:urbandrive/presentation/loading_pages/home_screen_shimmer.dart';
import 'package:urbandrive/presentation/pages/car_booking_screen.dart';

import 'package:urbandrive/presentation/pages/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, this.currentLocation, required this.isLocation});

  String? currentLocation;
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
                  backgroundColor: Color.fromARGB(255, 192, 221, 245),
                  //  titleSpacing: BorderSide.strokeAlignCenter,
                  elevation: 0,
                  pinned: true,
                  //expandedHeight: 10,
                  floating: false,
                  leading: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowProfileScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  title: ListTile(
                    subtitle: Text("User"),
                    title: Text(
                      "Hi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                            backgroundColor: Color.fromARGB(146, 228, 228, 228),
                            child: ImageIcon(AssetImage(
                                'lib/assets/images/notification.png'))

                            ///  Icon(Icons.search),
                            ),
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
                  final location= state.users.location;
               
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppbarLoaded(context, state),
                     sliverAppBar2(context, sWidth, location!)
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
                              trailing: Text(
                                "View All",
                                style: TextStyle(fontSize: 15),
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
                                            carId: carmodelslist[index].id,
                                            userId: userId!,
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Card(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                2,
                                            height: 170,
                                            child: CachedNetworkImage(
                                              imageUrl: carmodelslist[index]
                                                  .images
                                                  .first,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${carmodelslist[index].brand!} ${carmodelslist[index].model}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      carmodelslist[index]
                                                          .price!,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "9am -9pm",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Center(
                                                      child: Text(
                                                    carmodelslist[index]
                                                        .category!,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Colors.black,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                        "${carmodelslist[index].seats!} seats",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  height: 30,
                                                  width: 80,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Colors.black,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                        carmodelslist[index]
                                                            .transmit!,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  height: 30,
                                                  width: 80,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Container(
                            //   height: 100,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
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
      backgroundColor:Colors.blue,
      //  titleSpacing: BorderSide.strokeAlignCenter,
      elevation: 0,
      pinned: true,
      //expandedHeight: 10,
      floating: false,
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
        subtitle: Text(state.users.name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
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
                child:
                    ImageIcon(AssetImage('lib/assets/images/notification.png'),color: Colors.blue,)

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

  SliverAppBar sliverAppBar2(context, double width, String location) {
    return SliverAppBar(
      expandedHeight: 70,
      shadowColor: Colors.black,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),

      backgroundColor:Colors.blue,
      // pinned: true,
      flexibleSpace: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Container(
    
                  margin: EdgeInsets.only(left: 12),
                  width: 200,
                  height: 35,
                  child: isLocation == false
                      ? Center(
                        child:ListTile(leading: Icon(Icons.location_on),title:     Text("Location?",
                            style: TextStyle(color: Colors.white,
                                fontSize: 16, fontWeight: FontWeight.w600)),)
                        
                     ,
                      )
                      : Center(
                        child: ListTile(leading: Icon(Icons.location_on, color: Colors.white,),
                          title: Text(
                              "${location}",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                        ),
                      ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
   margin: EdgeInsets.only(top:10),
                child: Container(
                 
                  height: 50,
                  width: width-100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    
                    onTap: () {},
                    leading: Icon(Icons.search),
                    title: Text(
                      "Search for your car",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                
              ),
              SizedBox(width: 5,),
              Card(
                  margin: EdgeInsets.only(top:10),
                child: Container(
              

                  decoration: BoxDecoration(color:Colors.blue,border: Border.all(color: Colors.white,strokeAlign: BorderSide.strokeAlignInside), borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                height: 50,
                width: 50,
                child:ImageIcon(AssetImage('lib/assets/images/filter.png') ,size: 2,color: Colors.white,),),)
            ],
          ),
        ],
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
                      child: Text(
                        "BOOK NOW",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
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
