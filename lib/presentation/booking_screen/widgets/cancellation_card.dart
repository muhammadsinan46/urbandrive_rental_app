

import 'package:flutter/material.dart';

class CancellationCard extends StatelessWidget {
  const CancellationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromARGB(255, 118, 116, 116))),
        padding: EdgeInsets.only(
          left: 20,
        ),
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        child: ListTile(
          contentPadding: EdgeInsets.all(5),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.blue, fontSize: 18),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("Cancellation Charges"),
          ),
          subtitle: Text(
            "Cancellation charges will be applied as per the policy",
          ),
          trailing: TextButton(
            // style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.green))),
            onPressed: () {},
            child: Text(
              "Know more",
              style: TextStyle(
                  fontSize: 12, color: const Color.fromARGB(255, 62, 158, 206)),
            ),
          ),
        ));
  }
}