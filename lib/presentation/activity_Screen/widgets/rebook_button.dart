

import 'package:flutter/material.dart';

class RebookButton extends StatelessWidget {
  const RebookButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Rebook",
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue,
      ),
      height: 50,
      width: 140,
    );
  }
}