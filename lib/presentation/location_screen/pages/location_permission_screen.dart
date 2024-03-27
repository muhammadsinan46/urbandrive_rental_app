// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:urbandrive/domain/utils/user_authentication/user_auth_helper.dart';

import 'package:urbandrive/presentation/main_page/pages/main_page.dart';

class LocationPermissionScreen extends StatefulWidget {
  LocationPermissionScreen({super.key, required this.currentUser});

  final String currentUser;

  UserauthHelper userdata = UserauthHelper();

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  String? currentAddress;

  bool? isLocPermitted;

  getAddresslatLong(double lat, double long) async {
    await placemarkFromCoordinates(lat, long).then((List<Placemark> placemark) {
      Placemark place = placemark[0];

      setState(() {});
      currentAddress = place.locality;
    });

    Map<String, dynamic> location = {
      "location": currentAddress,
      "location-status":true      };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser)
        .update(location)
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
              
              ),
            ),
            (route) => false));
  }

  final locationPermission = Permission.location;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 248, 252),
      body: Center(
        child: Container(
          // color: Colors.green,
          height: 400,
          width: MediaQuery.sizeOf(context).width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Image.asset('lib/assets/images/permImage.png'),
                height: 300,
                width: MediaQuery.sizeOf(context).width - 100,
              ),
              GestureDetector(
                onTap: () => checkPermission(Permission.location, context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  height: 50,
                  width: MediaQuery.sizeOf(context).width - 200,
                  child: Center(
                      child: Text(
                    "ENABLE LOCATION",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(
                          
                          ),
                        ),
                        (route) => false);
                  },
                  child: Text(
                    "NOT NOW",
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkPermission(Permission permission, context) async {
    final status = await permission.request();

    if (status.isGranted) {
      isLocPermitted = true;
      final position = await Geolocator.getCurrentPosition();

      await getAddresslatLong(position.latitude, position.longitude);

      // final lang = position.latitude;
    } else {
      isLocPermitted = false;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
            
            ),
          ),
          (route) => false);
    }
  }
}
