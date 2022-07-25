import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/status_provider.dart';
import 'package:send_whatsapp/ui/widgets/status_screen_widget/video_tile.dart';

import '../widgets/status_screen_widget/image_tile.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  Directory? directory;
  String? path;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Consumer<StatusProvider>(builder: (context, value, widget) {
          return Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(value.isLoading)
              const LinearProgressIndicator(minHeight: 2,),
               if(value.imagePathList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'IMAGES',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (String imagePath in value.imagePathList)
                   ImageTileWidget(imagePath:imagePath),
                
                ],
              ) ,
              if(value.videoPathList.isNotEmpty)
               Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'VIDEOS',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor),
                ),
              ),
                GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                
                 for(int index= 0; index<value.videoThumbPathList.length;index++)
                VideoTileWIdget(index: index)
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
