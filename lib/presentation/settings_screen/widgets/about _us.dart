import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("About Us"),
      ),
      body: Card(
        child: Container(
        
          
          
          padding: EdgeInsets.all(8),
          height: MediaQuery.sizeOf(context).height-650,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.white,
          child: RichText(
          
            textAlign: TextAlign.justify,
            softWrap: true,
              text: TextSpan(children: [
            TextSpan(
              
                text: "Who we are ?\n",
                style: TextStyle(
                  
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            TextSpan(
              
                text:
                    "\nUrban drive is a Laxuray brand automobile rental providers which is incorporated on 4 April 2024  in Bengaluru, India. ",
                style: TextStyle(fontSize: 18, color: Colors.black,wordSpacing: 5)),
            TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black,wordSpacing: 5),
                text:
                    "\n\n We strive to be the premier platform where discerning individuals can easily access a diverse range of high-end vehicles, complemented by exceptional service and seamless convenience ")
          ])),
        ),
      ),
    );
  }
}
