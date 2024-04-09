
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/car_booking_bloc/car_booking_bloc.dart';
import 'package:urbandrive/domain/utils/booking/booking_screeen_helper.dart';
import 'package:urbandrive/presentation/booking_screen/pages/car_booking_screen.dart';

class BookingScreenAppBar extends StatelessWidget {
  const BookingScreenAppBar({
    super.key,
    required this.widget,
    required this.bookingDataHelper,
  });

  final CarBookingScreen widget;
  final BookingScreenHelper bookingDataHelper;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final scrolled = constraints.scrollOffset > 0;
    
        return SliverAppBar(
          leading: InkWell(
            onTap: () {
              if (widget.isEdit == true) {
                context.read<CarBookingBloc>().add(
                    UpcomingCarBookingLogEvent(
                        userId: widget.userId));
              }
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: scrolled ? Colors.white : Colors.blue,
            ),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.share,
                  color: scrolled ? Colors.white : Colors.blue,
                )),
          ],
          title: scrolled
              ? Text(
                  "${bookingDataHelper.carmodelData[0].brand} ${bookingDataHelper.carmodelData[0].model}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              : null,
          backgroundColor: scrolled ? Colors.blue : null,
          pinned: true,
        );
      },
    );
  }
}