// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:urbandrive/presentation/booking/widgets/history_tab.dart';
import 'package:urbandrive/presentation/booking/widgets/upcoming_tab.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Activity"),
            bottom: TabBar(tabs: [
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "History",
              ),
            ]),
          ),
          body: TabBarView(children: [
            UpcomingTabScreen(
              userId: userId,
            ),
            HistoryTabScreen(
              userId: userId,
            ),
          ])),
    );
  }
}
