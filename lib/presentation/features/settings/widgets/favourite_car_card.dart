import 'package:flutter/material.dart';

class FavouriteCarCard extends StatelessWidget {
  const FavouriteCarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      leading: ImageIcon(AssetImage('lib/assets/images/favcar.png')),
      title: Text("Favourite Cars"),

    );
  }
}