
import 'package:flutter/material.dart';
import 'package:urbandrive/infrastructure/booking-models/booking_model.dart';

class ShowDateDetails extends StatelessWidget {
   ShowDateDetails({
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
              child: Icon(Icons
                  .event_available_rounded),
            ),
            Container(
              width:
                  MediaQuery.sizeOf(context)
                          .width -
                      150,
              child: Text(
                maxLines: 5,
                "${bookingHistoryList![index].PickupDate}\t ${bookingHistoryList![index].pickMonth}"
                "-\t${bookingHistoryList![index].DropOffDate}\t${bookingHistoryList![index].dropMonth}",
                style:
                    TextStyle(fontSize: 16),
              ),
            )
          ],
        ));
  }
}


