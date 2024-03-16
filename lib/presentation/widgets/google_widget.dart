import 'package:flutter/material.dart';

class GoogleWidget extends StatelessWidget {
  const GoogleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(30)),
      height: 50,
      width: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'lib/assets/images/pngegg.png',
            width: 20,
            height: 20,
          ),
          const Text(
            "Continue with Google",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          // Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}
