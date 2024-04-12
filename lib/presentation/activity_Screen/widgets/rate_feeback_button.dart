// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateFeedBackButton extends StatelessWidget {
  RateFeedBackButton({
    super.key,
    required this.modelId,
    required this.userId,
    required this.bookingId,
  });

  final String modelId;
  final String userId;
  final String bookingId;

  var commentController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  double? ratingValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  title: Text("Rate & Feedback"),
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "what's your rate ? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      RatingBar.builder(
                        unratedColor: const Color.fromARGB(255, 195, 228, 243),
                        glow: false,
                        allowHalfRating: true,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),
                        onRatingUpdate: (value) {
                          ratingValue = value;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Comments :",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: "Share your feedback",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        controller: commentController,
                        maxLines: 5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    Map<String, dynamic> data = {
                      "rating": ratingValue,
                      "feedback": commentController.text,
                      "carmodel-id": modelId,
                      "user-id": userId,
                      "booking-id": bookingId
                    };

                    await await firestore
                        .collection('feedback')
                        .doc("${bookingId + userId}")
                        .set(data)
                        .then((value) {
                      commentController.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Thanks for your response")));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 5, 71, 125),
                    ),
                    height: 60,
                    width: MediaQuery.sizeOf(context).width - 10,
                    child: Center(
                        child: Text(
                      "Submit your feedback",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
      child: Container(
        child: Center(
          child: Text(
            "Rate & Feedback",
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
        height: 50,
        width: 140,
      ),
    );
  }
}
