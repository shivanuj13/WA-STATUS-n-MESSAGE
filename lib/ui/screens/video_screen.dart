import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/status_provider.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // bool isPlaying=false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(context.read<StatusProvider>().selectedVideoPath!))
      ..initialize().then((_) {
        setState(() {
        });
      });
      _controller.addListener(() {
        if(_controller.value.duration==_controller.value.position){
          setState(() {
            
          });
        }
       });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:28.0,right: 8),
            child: FloatingActionButton(
             
              onPressed: () {
                setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
              },
              child: Icon(
                _controller.value.isPlaying?
                Icons.pause:
                Icons.play_arrow,
                color: Theme.of(context).scaffoldBackgroundColor,
                size: 28,
              ),
            ),
          ), Padding(
            padding: const EdgeInsets.only(bottom:28.0,right: 8),
            child: FloatingActionButton(
               heroTag: null,
              onPressed: () {
               
                context.read<StatusProvider>().downloadMedia(context, context.read<StatusProvider>().selectedVideoPath!, true);
              },
              child: Icon(
                Icons.download,
                color: Theme.of(context).scaffoldBackgroundColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Consumer<StatusProvider>(builder: (context, value, widget) {
            return FittedBox(
              fit: BoxFit.contain,
              child:   _controller.value.isInitialized
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                      // aspectRatio: _controller.value.aspectRatio,
                      height: _controller.value.size.height,
                      width: _controller.value.size.width,
                      child: VideoPlayer(_controller)),
                  Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
                      child: VideoProgressIndicator(_controller,
                      padding: const EdgeInsets.only(top: 20),
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                              backgroundColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.5),
                              bufferedColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              playedColor: Theme.of(context).primaryColor)))
                ],
              ),
             
            ],
          )
        : const SizedBox(child: CircularProgressIndicator()));
          }),
        ),
      ),
    );
  }
}
