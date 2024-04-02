import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urbandrive/application/specific_category_bloc/specific_category_list_bloc.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';
import 'package:urbandrive/presentation/home_screen/widgets/show_car_detail_card.dart';

class CarModelListScreen extends StatelessWidget {
  CarModelListScreen({super.key, required this.category, required this.userId});

  String? category;
  String? userId;

  @override
  Widget build(BuildContext context) {
    context
        .read<SpecificCategoryBloc>()
        .add(SpecificCategoryLoadedEvent(carCategory: category));
    return Scaffold(
      appBar: AppBar( leading: IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back_ios_new)), title: Text(category!),),
      body: BlocBuilder<SpecificCategoryBloc, SpecificCategoryState>(
        builder: (context, state) {
          print(state.runtimeType);
          if (state is SpecificCategoryInitialState) {

          
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 2,
                    height: 170,
                    color: Colors.grey,
                  ),
                );
              },
            );
          } else if (state is SpecificCategoryLoadedState) {
            return ListView.builder(
              itemCount: state.specificCateList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarBookingScreen(
                              carId: state.specificCateList[index].id,
                              userId: userId!,
                              locationStatus: true,
                              isEdit: false),
                        ));
                  },
                  child: ShowCarDetailsCard(
                    carmodelslist: state.specificCateList,
                    index: index,
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
