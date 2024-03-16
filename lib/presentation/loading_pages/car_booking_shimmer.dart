import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class ShimmerCarBookingScreen extends StatelessWidget {
  const ShimmerCarBookingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final scrolled = constraints.scrollOffset > 0;
      
                return SliverAppBar(
                  actions: [Icon(Icons.share)],
                  title: scrolled ? Text("data") : null,
                  backgroundColor: scrolled
                      ? const Color.fromARGB(255, 241, 249, 255)
                      : null,
                  pinned: true,
                );
              },
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 2,
      
                          height: 220,
                       
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
                                    "model",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "  price!",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                  "category",
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
                                  child: Text("seats",
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
                                  child: Text(" carm",
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
                  ),
                ),
                Container(
                  color: Colors.red,
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Container(
                  color: Colors.cyan,
                  height: 150,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Container(
                  color: Colors.black54,
                  height: 400,
                  width: MediaQuery.sizeOf(context).width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}