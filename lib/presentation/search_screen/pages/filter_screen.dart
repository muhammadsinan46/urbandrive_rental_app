import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:urbandrive/infrastructure/brand_model/brand_model.dart';
import 'package:urbandrive/infrastructure/category_model/category_model.dart';
import 'package:urbandrive/application/search_bloc/search_bloc.dart';
import 'package:urbandrive/presentation/search_screen/search_repo.dart';
import 'package:urbandrive/presentation/search_screen/widgets/brandstyle_loading.dart';
import 'package:urbandrive/application/homescreen_bloc/homescreen_bloc_bloc.dart';

class CarFilterButton extends StatefulWidget {
  CarFilterButton({
    super.key,
  });

  @override
  State<CarFilterButton> createState() => _CarFilterButtonState();
}

class _CarFilterButtonState extends State<CarFilterButton> {
  SfRangeValues priceValues = SfRangeValues(0, 1000000.0);

  double _min = 0;
  double _max = 1000000;

  List<int> priceRange = [];

  final List<String> radioValues = [
    "Most popular",
    "Price Low to high",
    "Price High to Low"
  ];
  String? radioValue;
  List<BrandModel> brandlist = [];
  List<CategoryModel> categorylist = [];

  List<int> carstyleItems = [];
  List<String> carselectedStyle = [];
  List<String> carbrandselected = [];

  @override
  Widget build(BuildContext context) {
    context.read<HomescreenBloc>().add(HomescreenLoadedEvent());
    context.read<SearchBloc>().add(SearchScreenInitialEvent());
    return InkWell(
      onTap: () {
        context.read<SearchBloc>().add(SearchScreenInitialEvent());
        double maxHeight = MediaQuery.sizeOf(context).height;
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                        title: Text(
                          "Filter",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      Container(
                        height: 200,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Sort by",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            StatefulBuilder(
                              builder: (context, rstate) {
                                return RadioGroup.builder(
                                  groupValue: radioValue,
                                  onChanged: (values) {
                                    rstate(() {
                                      radioValue = values!;
                                    });
                                  },
                                  items: radioValues,
                                  itemBuilder: (value) =>
                                      RadioButtonBuilder(value!),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Price range",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            StatefulBuilder(
                              builder: (context, state) {
                                return SfRangeSliderTheme(
                                  data: SfRangeSliderThemeData(
                                      thumbColor: Colors.white,
                                      tooltipTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.blue),
                                      tooltipBackgroundColor:
                                          Colors.transparent),
                                  child: SfRangeSlider(
                                    thumbShape: SfThumbShape(),
                                    shouldAlwaysShowTooltip: true,
                                    tooltipShape: SfRectangularTooltipShape(),
                                    inactiveColor: const Color.fromARGB(
                                        255, 238, 238, 238),
                                    activeColor: Colors.blue,
                                    numberFormat: NumberFormat("₹"),
                                    min: 0,
                                    max: 1000000,
                                    showTicks: true,
                                    showLabels: true,
                                    enableTooltip: true,
                                    values: priceValues,
                                    onChanged: (value) {
                                      state(() {
                                        _min = value.start;
                                        _max = value.end;
                                        priceRange = [
                                          _min.round(),
                                          _max.round()
                                        ];
                                        priceValues = value;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<HomescreenBloc, HomescreenState>(
                        builder: (context, state) {
                          if (state is HomescreenLoadingState) {
                            return BrandAndStyleLoading();
                          } else if (state is HomescreenLoadedState) {
                            brandlist = state.brandList;
                            categorylist = state.categorylist;

                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Car Style",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                      Container(
                                        height: 250,
                                        width: MediaQuery.sizeOf(context).width,
                                        child: StatefulBuilder(
                                          builder: (context, styleState) =>
                                              GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 1.2,
                                                    crossAxisSpacing: 8,
                                                    mainAxisSpacing: 10,
                                                    crossAxisCount: 3),
                                            itemCount: categorylist.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () => styleState(() {
                                                  final value =
                                                      categorylist[index].name;
                                                  if (carselectedStyle
                                                      .contains(value)) {
                                                    // carstyleItems.remove(index);
                                                    carselectedStyle
                                                        .remove(value);
                                                  } else {
                                                    carselectedStyle
                                                        .add(value!);
                                                    // carstyleItems.add(index);
                                                  }
                                                }),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: carselectedStyle
                                                            .contains(
                                                                categorylist[
                                                                        index]
                                                                    .name)
                                                        ? Colors.blue
                                                        : null,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: CachedNetworkImage(
                                                            imageUrl:
                                                                '${categorylist[index].image}'),
                                                        height: 80,
                                                        width: 150,
                                                      ),
                                                      Text(
                                                        "${categorylist[index].name}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  //    height: 300,
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Brands",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                          height: 500,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: StatefulBuilder(
                                            builder: (context, brState) =>
                                                GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 1.2,
                                                      crossAxisSpacing: 8,
                                                      mainAxisSpacing: 10,
                                                      crossAxisCount: 3),
                                              itemCount: brandlist.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () => brState(() {
                                                    if (carselectedStyle
                                                        .contains(
                                                            brandlist[index]
                                                                .name)) {
                                                      carselectedStyle.remove(
                                                          brandlist[index]
                                                              .name);
                                                    } else {
                                                      carselectedStyle.add(
                                                          brandlist[index]
                                                              .name!);
                                                    }
                                                  }),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: carselectedStyle
                                                                .contains(
                                                                    brandlist[
                                                                            index]
                                                                        .name)
                                                            ? Colors.blue
                                                            : null),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child: CachedNetworkImage(
                                                              imageUrl:
                                                                  '${brandlist[index].logo}'),
                                                          height: 80,
                                                          width: 150,
                                                        ),
                                                        Text(
                                                          "${brandlist[index].name}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
                height: maxHeight - 50,
              ),
              bottomNavigationBar: Container(
                color: Colors.white,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        carselectedStyle.clear();
                        priceRange.clear();
                        context
                            .read<SearchBloc>()
                            .add(SearchScreenInitialEvent());
                        Navigator.pop(context);
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 231, 231, 231),
                          ),
                          height: 50,
                          width: 160,
                          child: Center(child: Text("Clear")),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (carselectedStyle.isNotEmpty) {
                          context.read<SearchBloc>().add(CarStyleFilterEvent(
                              filterData: carselectedStyle));
                        } else if (priceRange.isNotEmpty) {
                          context.read<SearchBloc>().add(
                              PriceRangeFilterEvent(priceRange: priceRange));
                        } else if (radioValue!.isNotEmpty) {
                          context.read<SearchBloc>().add(
                              PriceSortFilterEvent(radioValue: radioValue!));
                        } else {
                          context
                              .read<SearchBloc>()
                              .add(SearchScreenInitialEvent());
                        }

                        //  carselectedStyle.clear();
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        height: 50,
                        width: 160,
                        child: Center(
                            child: Text(
                          "Show Result ",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                  color: Colors.white,
                  strokeAlign: BorderSide.strokeAlignInside),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          height: 50,
          width: 50,
          child: ImageIcon(
            AssetImage('lib/assets/icons/filter.png'),
            size: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
