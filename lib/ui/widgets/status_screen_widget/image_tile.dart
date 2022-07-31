import 'dart:io';

import 'package:flutter/material.dart';

import '../../screens/image_screen.dart';

class ImageTileWidget extends StatelessWidget {
  const ImageTileWidget({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePage(imagePath: imagePath,)) );
      },
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          margin: const EdgeInsets.all(4),
          elevation: 2,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                File(imagePath),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ))),
    );
  }
}
