
import 'package:flutter/material.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';

class ShowLocationDetails extends StatelessWidget {
   ShowLocationDetails({
    super.key,
    required this.bookingHistoryList,
    required this.index
  });

  final List<BookingModel>? bookingHistoryList;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: MediaQuery.sizeOf(context)
                .width -
            120,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
          children: [
            Container(
              height: 20,
              width: 20,
              child:
                  Icon(Icons.location_on),
            ),
            Container(
              width:
                  MediaQuery.sizeOf(context)
                          .width -
                      150,
              child: Text(
                maxLines: 5,
                "${bookingHistoryList![index].PickupAddress}",
                style:
                    TextStyle(fontSize: 12),
              ),
            )
          ],
        ));
  }
}