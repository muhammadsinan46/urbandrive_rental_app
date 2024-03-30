

import 'package:flutter/material.dart';
import 'package:urbandrive/infrastructure/car_model/car_model.dart';

class PriceConfirmCard extends StatelessWidget {
  const PriceConfirmCard({
    super.key,
    required this.carmodel,
    required this.ConFee,
    required this.taxAmount,
    required this.discount,
    required this.totalamount,
  });

  final List<CarModels> carmodel;
  final int ConFee;
  final int taxAmount;
  final int discount;
  final int totalamount;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
            color: Color.fromARGB(255, 237, 245, 249),
                            //  color: Colors.amberAccent,
                            width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white, width: 4),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    "Price Summary",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400),
                  ),
                  ListTile(
                    title: Text(
                      "price Amount",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 106, 106, 106),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Text("${carmodel[0].price}",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(
                                255, 106, 106, 106),
                            fontWeight: FontWeight.w400)),
                  ),
                  ListTile(
                    title: Text(
                      "Deposit Amount",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 106, 106, 106),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Text("${carmodel[0].deposit}",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(
                                255, 106, 106, 106),
                            fontWeight: FontWeight.w400)),
                  ),
                  ListTile(
                    title: Text(
                      "Convenience  Fee",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 106, 106, 106),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Text("${ConFee}",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(
                                255, 106, 106, 106),
                            fontWeight: FontWeight.w400)),
                  ),
                  ListTile(
                    title: Text(
                      "Tax(GST)",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(
                              255, 106, 106, 106),
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Text("${taxAmount}",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(
                                255, 106, 106, 106),
                            fontWeight: FontWeight.w400)),
                  ),
                  ListTile(
                    title: Text(
                      "discount applied",
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(
                              255, 106, 106, 106),
                          fontWeight: FontWeight.w400),
                    ),
                    leading: Image.asset(
                      'lib/assets/icons/discount.png',
                      height: 20,
                      width: 20,
                    ),
                    trailing: Text("-${discount}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(
                                255, 160, 160, 160),
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
                                    
            //  Divider(),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white, width: 4),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text("Total"),
                trailing: Text("₹ ${totalamount}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(
                            255, 160, 160, 160),
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



