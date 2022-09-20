import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:folder_file_saver/folder_file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';
import 'package:send_whatsapp/ui/util/error_dialogue.dart';
import 'package:send_whatsapp/ui/widgets/shared/permission_dialogue_widget.dart';
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
    {
      if (await Permission.storage.isDenied) {
        PermissionStatus status = await Permission.storage.request();
        int? sdkVersion = await DeviceInfoPlugin()
            .androidInfo
            .then((value) => value.version.sdkInt);

        if (sdkVersion != null && sdkVersion >= 30) {
          Completer<void> completer=Completer();
          showDialog(
              context: context,
              builder: (context) => PermissionDialogueWidget(onTap: (){
                completer.complete();
              },));

              await completer.future;
         
          
        }

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
  }

  Future<void> fetchMedia(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await permissionHandler(context);

    int? sdkVersion = await DeviceInfoPlugin()
        .androidInfo
        .then((value) => value.version.sdkInt);

    if (sdkVersion != null && sdkVersion < 30) {
      List<String> whatsAppPaths = await _findWhatsAppPath();
      await _fetchImages(whatsAppPaths);
      notifyListeners();
      await _fetchVideos(whatsAppPaths);
      isLoading = false;
    } else {
      await _fetchMediaInSdkGreat29();
      isLoading = false;
    }
    notifyListeners();
  }

  Future<List<String>> _findWhatsAppPath() async {
    Directory? directory = await getExternalStorageDirectory();
    List<String> whatsAppPaths = [];
    List<String> whatsAppTypes = ['WhatsApp', 'WhatsApp Business'];
    String rootPath = "";

    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        rootPath += "/$folder";
      } else {
        break;
      }
    }
    for (String whatsAppType in whatsAppTypes) {
      String tmpWhatsAppPath = "$rootPath/$whatsAppType/Media/.Statuses";
      whatsAppPaths.add(tmpWhatsAppPath);
    }

    return whatsAppPaths;
  }

  Future<void> _fetchMediaInSdkGreat29() async {
    Saf saf = Saf("Android/media/com.whatsapp/WhatsApp/Media/.Statuses");
    bool? isGranted = await saf.getDirectoryPermission(isDynamic: true);

    await saf.clearCache();
    if (isGranted != null && isGranted) {
      bool? isSync = await saf.sync();
      if (isSync != null && isSync) {
        List<String>? paths = await saf.getCachedFilesPath();
        if (paths != null) {
          _loadMediaInSdkGreat29(paths);
        }
      }
    }
  }

  Future<void> _loadMediaInSdkGreat29(List<String> paths) async {
    imagePathList = paths
        .map((item) => item)
        .where((item) => item.endsWith('.jpg'))
        .toList();
    videoPathList = paths
        .map((item) => item)
        .where((item) => item.endsWith('.mp4'))
        .toList();

    notifyListeners();
    await _createThumb();
    notifyListeners();
  }

  Future<void> _fetchImages(List<String> whatsAppPaths) async {
    List<String> imagePathList = [];
    for (String whatsAppPath in whatsAppPaths) {
      try {
        List<FileSystemEntity> whatsAppDir =
            await Directory(whatsAppPath).list().toList();
        for (FileSystemEntity element in whatsAppDir) {
          if (element.path.split('.').last == "jpg") {
            imagePathList.add(element.path);
          }
        }
      } on FileSystemException {
        null;
      }
    }

    this.imagePathList = imagePathList;
  }

  Future<void> _fetchVideos(List<String> whatsAppPaths) async {
    List<String> videoPathList = [];
    for (String whatsAppPath in whatsAppPaths) {
      try {
        List<FileSystemEntity> whatsAppDir =
            await Directory(whatsAppPath).list().toList();
        for (FileSystemEntity element in whatsAppDir) {
          if (element.path.split('.').last == "mp4") {
            videoPathList.add(element.path);
          }
        }
      } on FileSystemException {
        null;
      }
    }

    this.videoPathList = videoPathList;
    await _createThumb();
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

    FolderFileSaver.saveFileToFolderExt(mediaPath);

    isDownLoading = false;
    notifyListeners();
  }
}
