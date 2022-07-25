
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/status_provider.dart';

class VideoTileWIdget extends StatelessWidget {
 const VideoTileWIdget({Key? key, required this.index}) : super(key: key);


 final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.all(10),
        elevation: 6,
        child: Consumer<StatusProvider>(
          builder: (context,value,widget) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.memory(
                      value.videoThumbPathList.elementAt(index),
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.vertical(bottom: Radius.circular(5)),
                        color: Colors.white.withOpacity(0.9)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: IconButton(
                            onPressed: () {
                              // print('play');
                              value.selectVideo(context, index);
                           },
                            icon: Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 35,
                              shadows: const [Shadow(offset: Offset(2, 2), blurRadius: 15)],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: IconButton(
                            onPressed: () {
                              // print('download');
                              value.downloadMedia(context, value.videoPathList.elementAt(index),true);
                            },
                            icon: Icon(
                              Icons.download,
                              color: Theme.of(context).primaryColor,
                              size: 35,
                              shadows: const [Shadow(offset: Offset(2, 2), blurRadius: 15)],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            );
          }
        ));
  }
}
