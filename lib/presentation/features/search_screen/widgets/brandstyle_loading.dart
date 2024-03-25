
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BrandAndStyleLoading extends StatelessWidget {
  const BrandAndStyleLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            //    height: 300,
            child: Column(
              children: [
                Text("Car Style"),
                Container(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        crossAxisCount: 3),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(border: Border.all()),
                        height: 80,
                        width: 80,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            //    height: 300,
            child: Column(
              children: [
                Text("Brands"),
                Container(
                  height: 400,
                  width: MediaQuery.sizeOf(context).width,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.2, crossAxisCount: 4),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(border: Border.all()),
                        height: 80,
                        width: 80,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
