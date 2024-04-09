

import 'package:flutter/material.dart';

class AppbarLoading extends StatelessWidget {
  const AppbarLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey.shade100,
      //  titleSpacing: BorderSide.strokeAlignCenter,
      elevation: 0,
      pinned: true,
      //expandedHeight: 10,
      floating: false,
      leading: Container(
        margin: EdgeInsets.only(left: 5),
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.person),
        ),
      ),
    
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
    
            ///  Icon(Icons.search),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
          );
        },
      ),
    );
  }
}