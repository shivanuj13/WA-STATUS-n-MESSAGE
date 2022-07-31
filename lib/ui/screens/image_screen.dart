import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/status_provider.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key? key, required this.imagePath}) : super(key: key);
  String imagePath;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:28.0,right: 8),
        child: FloatingActionButton(
          onPressed: () {
           
            context.read<StatusProvider>().downloadMedia(context, widget.imagePath, false);
          },
          child: Icon(
            Icons.download,
            color: Theme.of(context).scaffoldBackgroundColor,
            size: 28,
          ),
        ),
      ),
     body: PhotoView(
      imageProvider: FileImage(File(widget.imagePath)),)

    );
  }
}