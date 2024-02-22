import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicker extends StatefulWidget {
  ProfilePicker({
    super.key,
    required this.imageFile,
    required this.user,
  });

  File? imageFile;
  final User? user;
  bool isImageAvailable = false;
  @override
  State<ProfilePicker> createState() => _ProfilePickerState();
}

class _ProfilePickerState extends State<ProfilePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        uploadImage(context);
      },
      child: CircleAvatar(
          child: Container(
        child: widget.isImageAvailable
            ? Image.file(widget.imageFile!)
            : Icon(Icons.add_a_photo),
      )

          // NetworkImage(widget.user!.photoURL!)
          ),
    );
  }

  uploadImage(context) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        widget.imageFile = File(file.path);
        widget.isImageAvailable = true;
      });
    }
  }
}
