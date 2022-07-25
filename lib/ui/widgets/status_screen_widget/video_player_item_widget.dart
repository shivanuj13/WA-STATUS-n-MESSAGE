import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItemWidget extends StatefulWidget {
  const VideoPlayerItemWidget({Key? key, required this.videoPath})
      : super(key: key);
  final String videoPath;

  @override
  State<VideoPlayerItemWidget> createState() => _VideoPlayerItemWidgetState();
}

class _VideoPlayerItemWidgetState extends State<VideoPlayerItemWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {
        }); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
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
                          allowScrubbing: false,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  iconSize: 80,
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          )
        : const SizedBox(child: CircularProgressIndicator());
  }
}
