
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/status_provider.dart';

class VideoTileWIdget extends StatelessWidget {
 const VideoTileWIdget({Key? key, required this.index}) : super(key: key);


 final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(4),
        elevation: 2,
        child: Consumer<StatusProvider>(
          builder: (context,value,widget) {
            return InkWell(
              onTap: () {
                value.selectVideo(context, index);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.memory(
                    value.videoThumbPathList.elementAt(index),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
            );
          }
        ));
  }
}
