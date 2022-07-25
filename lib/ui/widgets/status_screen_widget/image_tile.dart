import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/status_provider.dart';

class ImageTileWidget extends StatelessWidget {
  const ImageTileWidget({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        elevation: 6,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(imagePath),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            InkWell(
              onTap: () {
                context
                    .read<StatusProvider>()
                    .downloadMedia(context, imagePath, false);
              },
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(bottom: Radius.circular(10)),
                      color: Colors.white.withOpacity(0.9)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.download,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                      shadows: const [Shadow(offset: Offset(2, 2), blurRadius: 20)],
                    ),
                  )),
            )
          ],
        ));
  }
}
