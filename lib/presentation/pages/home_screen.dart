import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/hom_screen_bloc/homescreen_bloc_bloc.dart';
import 'package:urbandrive/domain/brand_model.dart';
import 'package:urbandrive/domain/category_model.dart';
import 'package:urbandrive/domain/car_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    context.read<HomescreenBloc>().add(HomescreenLoadedEvent());

    return Scaffold(
      body: BlocBuilder<HomescreenBloc, HomescreenState>(
        builder: (context, state) {
          List<Widget> carousalItems = List.generate(4, (index) => CarousalFirst());

          if (state is HomescreenLoadingState) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  sliverAppbar1(),
                  sliverAppBar2(context, MediaQuery.of(context).size.width),
                ];
              },
              body: _buildLoadingBody(carousalItems),
            );
          } else if (state is HomescreenLoadedState) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  sliverAppbar1(),
                  sliverAppBar2(context, MediaQuery.of(context).size.width),
                ];
              },
              body: _buildLoadedBody(state.brandList, state.categorylist, state.carmodelsList, carousalItems),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildLoadingBody(List<Widget> carousalItems) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(12),
            height: 100,
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
                        backgroundColor: Colors.red,
                        radius: 40,
                      ),
                      Text("data"),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CarouselSlider(
            items: carousalItems,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
            ),
          ),
        ),
        // Add more slivers for other sections...
      ],
    );
  }

  Widget _buildLoadedBody(
    List<BrandModel> brandList,
    List<CategoryModel> categoryList,
    List<CarModels> carModelsList,
    List<Widget> carousalItems,
  ) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "Brands",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: brandList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(brandList[index].logo!),
                              radius: 40,
                            ),
                            Text(brandList[index].name!),
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
        // Add more slivers for other sections...
      ],
    );
  }

  SliverAppBar sliverAppbar1() {
    // Implement your sliverAppBar1
    return SliverAppBar();
  }

  SliverAppBar sliverAppBar2(context, double width) {
    // Implement your sliverAppBar2
    return SliverAppBar();
  }
}

class CarousalFirst extends StatelessWidget {
  const CarousalFirst({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Your carousel widget...
      child: Container(),
    );
  }
}
