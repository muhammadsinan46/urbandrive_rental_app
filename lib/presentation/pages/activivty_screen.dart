
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
      
            Tab(text: "Upcoming",),
            Tab(text: "History",),
          ]),
        ),
        body:TabBarView(children: [
          UpcomingTab(),
              HistoryTab()
        ])),
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                child: ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) {
                return  ListTile(title: Text("history"));
                },),
              );
  }
}

class UpcomingTab extends StatelessWidget {
  const UpcomingTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
      return  ListTile(title: Text("upcoming"),);
      },),
    );
  }
}