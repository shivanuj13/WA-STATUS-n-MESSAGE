import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/status_provider.dart';
import 'package:send_whatsapp/ui/widgets/status_screen_widget/video_player_item_widget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         
          context.read<StatusProvider>().downloadMedia(context, context.read<StatusProvider>().selectedVideoPath!, true);
        },
        child: Icon(
          Icons.download,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: 28,
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Consumer<StatusProvider>(builder: (context, value, widget) {
            return FittedBox(
              fit: BoxFit.contain,
              child: VideoPlayerItemWidget(videoPath: value.selectedVideoPath!));
          }),
        ),
      ),
    );
  }
}
