import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urbandrive/infrastructure/brand_model/brand_model.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';
import 'package:urbandrive/presentation/home_screen/pages/home_screen.dart';
import 'package:urbandrive/presentation/home_screen/widgets/homescreen_carousal.dart';
class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({
    super.key,
    required this.sWidth,
    required this.brandlist,
    required this.sHeight,
    required this.carmodelslist,
  });

  final double sWidth;
  final List<BrandModel> brandlist;
  final double sHeight;
  final List<CarModels> carmodelslist;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: CustomScrollView(
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
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          width: 100,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 30,
                              ),
                             
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
          // SliverToBoxAdapter(child: CarousalFirst(sWidth: sWidth, carmodelsList: [],)
          //     //  CarouselSlider(
          //     //     items: carousalitems,
          //     //     options: CarouselOptions(
          //     //       autoPlay: true,
          //     //       aspectRatio: 2.0,
          //     //       // enlargeCenterPage: true
          //     //     )),
          //     ),
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
                      "Available Cars",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "View All",
                      style: TextStyle(fontSize: 15),
                    ),
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
  }
}