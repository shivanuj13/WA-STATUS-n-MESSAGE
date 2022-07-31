import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:send_whatsapp/ui/util/error_dialogue.dart';
import 'package:send_whatsapp/ui/widgets/status_screen_widget/dialogue_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../ui/screens/video_screen.dart';

class StatusProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isDownLoading = false;
  List<String> imagePathList = [];
  List<String> videoPathList = [];
  List<Uint8List> videoThumbPathList = [];
  String? selectedVideoPath;

  Future<void> permissionHandler(BuildContext context) async {
    if (await Permission.storage.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      if (status.isDenied) {
        showDialog(
            context: context,
            builder: (context) => errorDialogue(context, permissionHandler));
      } else if (status.isPermanentlyDenied) {
        showDialog(
            context: context,
            builder: (context) => errorDialogue(context, (context) async {
                  openAppSettings();
                }));
      }
    }
  }

  Future<void> fetchMedia(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await permissionHandler(context);
    String whatsAppPath = await _findWhatsAppPath(whatsAppType: 'WhatsApp');
    String whatsAppBusinessPath = await _findWhatsAppPath(whatsAppType: 'WhatsApp Business');
    await _fetchImages(whatsAppPath,whatsAppBusinessPath);
    notifyListeners();
    await _fetchVideos(whatsAppPath,whatsAppBusinessPath);
    isLoading = false;
    // print(imagePathList);
    // print(videoPathList);
    // print(videoThumbPathList);
    notifyListeners();
  }

  Future<String> _findWhatsAppPath({required String whatsAppType}) async {
    Directory? directory = await getExternalStorageDirectory();
    String whatsAppPath = "";
    // print(directory);
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        whatsAppPath += "/$folder";
      } else {
        break;
      }
    }
    whatsAppPath = "$whatsAppPath/$whatsAppType/Media/.Statuses";
    // print(whatsAppPath);
    return whatsAppPath;
  }

  Future<void> _fetchImages(String whatsAppPath, String whatsAppBusinessPath) async {
    List<String> imagePathList = [];
    try {
  List<FileSystemEntity> whatsAppDir = await Directory(whatsAppPath).list().toList();
   for (FileSystemEntity element in whatsAppDir) {
      if (element.path.split('.').last == "jpg") {
        imagePathList.add(element.path);
      }
    }
} on FileSystemException {
null;
}
   
    try {
  List<FileSystemEntity> whatsAppBusinessDir = await Directory(whatsAppBusinessPath).list().toList();
  for (FileSystemEntity element in whatsAppBusinessDir) {
    if (element.path.split('.').last == "jpg") {
      imagePathList.add(element.path);
    }
  }
} on FileSystemException {
null;
}
    this.imagePathList = imagePathList;
    // print(this.imagePathList);
  }

  Future<void> _fetchVideos(String whatsAppPath, String whatsAppBusinessPath) async {
    List<String> videoPathList = [];
    try {
  List<FileSystemEntity> whatsAppDir = await Directory(whatsAppPath).list().toList();
  for (FileSystemEntity element in whatsAppDir) {
    if (element.path.split('.').last == "mp4") {
      videoPathList.add(element.path);
    }
  }
 
} on FileSystemException {
null;
}
try {
  List<FileSystemEntity> whatsAppBusinessDir = await Directory(whatsAppBusinessPath).list().toList();
  for (FileSystemEntity element in whatsAppBusinessDir) {
    if (element.path.split('.').last == "mp4") {
      videoPathList.add(element.path);
    }
  }
 
} on FileSystemException {
null;
}
 this.videoPathList = videoPathList;
  await _createThumb();

    // print(this.imagePathList);
  }

  Future<void> _createThumb() async {
    List<Uint8List> thumbPathList = [];
    for (String videoPath in videoPathList) {
      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
      );
      if (uint8list != null) {
        thumbPathList.add(uint8list);
      }
    }

    videoThumbPathList = thumbPathList;
  }

  void selectVideo(BuildContext context, int index) {
    selectedVideoPath = videoPathList.elementAt(index);
    notifyListeners();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const VideoPage()));
  }

  Future<void> downloadMedia(
      BuildContext context, String mediaPath, bool isVideo) async {
    isDownLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const DialogueWidget();
        });
    String fileExtension = isVideo ? ".mp4" : ".jpg";
    String fileStart = isVideo ? "vid" : "img";
    String appPath = await _findAppPath();
    File imageFile = File(mediaPath);
    File newFile = await imageFile
        .copy('$appPath/$fileStart-${DateTime.now()}$fileExtension');
    // print(newFile);
    await MediaScanner.loadMedia(path: newFile.path);
    isDownLoading = false;
    notifyListeners();
  }

  Future<String> _findAppPath() async {
    Directory? directory = await getExternalStorageDirectory();
    String appPath = "";
    // print(directory);
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        appPath += "/$folder";
      } else {
        break;
      }
    }
    appPath = "$appPath/WA Saver";

    if (!await Directory(appPath).exists()) {
      Directory dir = await Directory(appPath).create();
      // print(dir.path);
      return dir.path;
    }
    // print(appPath);
    return appPath;
  }
}
