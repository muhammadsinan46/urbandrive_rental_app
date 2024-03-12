// ignore_for_file: must_be_immutable


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/hom_screen_bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/domain/brand_model.dart';
import 'package:urbandrive/domain/car_model.dart';
import 'package:urbandrive/domain/category_model.dart';
import 'package:urbandrive/infrastructure/user_model.dart';
import 'package:urbandrive/presentation/pages/car_booking_screen.dart';

import 'package:urbandrive/presentation/pages/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
              return [sliverAppbar1(context),
              
            //   sliverAppBar2(context, sWidth)
               ];
            },
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    height: 100,
                    width: sWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: [
                              CircleAvatar(
                               // backgroundColor: Colors.red,
                                radius: 40,
                              ),
                              Text("data")
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child:CarousalFirst(sWidth: sWidth)
                  //  CarouselSlider(
                  //     items: carousalitems,
                  //     options: CarouselOptions(
                  //       autoPlay: true,
                  //       aspectRatio: 2.0,
                  //       // enlargeCenterPage: true
                  //     )),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(
                          "Caterogies",
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
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 12),
                              height: 120,
                              width: 150,
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    //  width: 150,
                                    color: Colors.blue,
                                  ),
                                  Text("data")
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
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            "Popular Cars",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),

                       
                          // trailing: Text(
                          //   "View All",
                          //   style: TextStyle(fontSize: 15),
                          // ),
                        ),
                        Container(
                          //  color: Colors.red,
                          height: sHeight,
                          width: sWidth,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // primary: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.7,
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 2),
                            itemCount: carmodelslist.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  height: 200);
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomescreenLoadedState) {
          brandlist = state.brandList;
          categorylist = state.categorylist;
          carmodelslist = state.carmodelsList;
      
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                
                           
                    if (state is UsersLoadedState) {
                      userId = state.users.id;
                        
                      return SliverAppBar(
                        backgroundColor: Color.fromARGB(255, 192, 221, 245),
                        //  titleSpacing: BorderSide.strokeAlignCenter,
                        elevation: 0,
    pinned: true,
                        //expandedHeight: 10,
                        floating: false,
                        leading: GestureDetector(
                          onTap:(){
                        
                           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowProfileScreen()));
                          } ,
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            child: Icon(Icons.person),
                            ),
                          ),
                        ),
                        title: ListTile(
                          subtitle: Text(state.users.name),
                          title: Text("Hi", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        actions: [
                          GestureDetector(
                            onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowProfileScreen()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(146, 228, 228, 228),
                                child: Icon(Icons.search),
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
                              //background: ,
                            );
                          },
                        ),
                      );
                    } else
                    //  if (state is UsersLoadingState) 
                     {
                      return SliverAppBar(
                        backgroundColor: Color.fromARGB(255, 192, 221, 245),
                        //  titleSpacing: BorderSide.strokeAlignCenter,
                        elevation: 0,
                  pinned: true,
                        //expandedHeight: 10,
                        floating: false,
                        leading: GestureDetector(
                          onTap: (){
                             
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            child: CircleAvatar(
                              child: Icon(Icons.person),
                              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        title: ListTile(
                          subtitle: Text("User"),
                          title: Text("Hi", style: TextStyle(fontWeight:FontWeight.bold ),),
                        ),
                        actions: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(146, 228, 228, 228),
                              child: GestureDetector(
                                onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowProfileScreen()));
                                },
                                child: Icon(Icons.search)),
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
                              //background: ,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              //  sliverAppBar2(context, sWidth)
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
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                      // backgroundColor: Colors.red,
                                      backgroundImage:
                                          NetworkImage(brandlist[index].logo!),
                                      radius: 40,
                                    ),
                                    Text(brandlist[index].name!)
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
             
                     child:CarousalFirst(sWidth: sWidth)
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
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                categorylist[index].image!))),
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
                  child: Card(
                    color: Color.fromARGB(255, 237, 244, 245),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            "Popular Cars",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          // trailing: Text(
                          //   "View All",
                          //   style: TextStyle(fontSize: 15),
                          // ),
                        ),
                        Container(
                          //  color: Colors.red,
                          height: sHeight,
                          width: sWidth,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // primary: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.5,
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 5),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CarBookingScreen(carId: carmodelslist[index].id,userId:userId! ,),)),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Card(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  2,
                                          height: 170,
                                          child: CachedNetworkImage(imageUrl: carmodelslist[index].images.first, fit: BoxFit.cover,),
                                         
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                    carmodelslist[index].price!,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "9am -9pm",
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                                                        BorderRadius.circular(7)),
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
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Colors.black,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      "${carmodelslist[index].seats!} seats",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                  borderRadius:
                                                      BorderRadius.circular(7),
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
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }

  SliverAppBar sliverAppbar1(context) {
    return SliverAppBar(
      backgroundColor: Color.fromARGB(255, 192, 221, 245),
      //  titleSpacing: BorderSide.strokeAlignCenter,
      elevation: 0,

      //expandedHeight: 10,
      floating: false,
      leading: GestureDetector(
        onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowProfileScreen()));
        },
        child: Container(
          margin: EdgeInsets.only(left: 5),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
        ),
      ),
      title: ListTile(
        subtitle: Text("User"),
        title: Text("Hi", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      actions: [
        // Container(
        //   margin: EdgeInsets.only(right: 10),
        //   child: GestureDetector(
        //     onTap: (){
              
        //     },
        //     child: CircleAvatar(
        //       backgroundColor: Color.fromARGB(146, 228, 228, 228),
        //       child: Icon(Icons.search),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // )
      ],

      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            //background: ,
          );
        },
      ),
    );
  }

  SliverAppBar sliverAppBar2(context, double width) {
    return SliverAppBar(
      shadowColor: Colors.black,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      backgroundColor: Color.fromARGB(255, 192, 221, 245),
      //   backgroundColor: const Color.fromARGB(255, 217, 217, 217),
      pinned: true,
      title: Container(
        height: 50,
        width: width,
        child: TextField(
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Search for your car",
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.search,
                size: 20,
              )),
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
