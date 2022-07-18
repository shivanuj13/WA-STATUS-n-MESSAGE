import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageProvider extends ChangeNotifier {
 
  Future<void> sendMessage(String phoneNo,String message) async {
    if (phoneNo != null && phoneNo.length == 10) {
      Uri url = Uri.parse(convertUrl(phoneNo, message));
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  String convertUrl(String phone, String message) {
    if (Platform.isAndroid) {
      return "https://wa.me/+91$phone/?text=${Uri.parse(message)}";
    } else {
      return "https://api.whatsapp.com/send?phone=+91$phone=${Uri.parse(message)}";
    }
  }
}
