import 'package:flutter/material.dart';
import 'package:urbandrive/presentation/favourite_screen/pages/favouite_screen.dart';

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen(),)),
      
      leading: ImageIcon(AssetImage('lib/assets/icons/favcar.png')),
      title: Text("Favourite Cars"),

    );
  }
}