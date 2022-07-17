import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url(String phone, String message) {
    if (Platform.isAndroid) {
      return "https://wa.me/+91$phone/?text=${Uri.parse(message)}";
    } else {
      return "https://api.whatsapp.com/send?phone=+91$phone=${Uri.parse(message)}";
    }
  }

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('MESSAGE TO ANYONE'),
        ),
        child: SafeArea(
          child: 
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Image.asset(
                              "asset/image/whatsapp.gif",
                              width: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                'SEND ON WHATSAPP',
                                style: TextStyle(
                                    color: Color(0xff075E54), fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            CupertinoTextField(
                              prefix: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(CupertinoIcons.phone),
                              ),
                              maxLength: 10,
                              controller: _phone,
                              keyboardType: TextInputType.phone,
                              placeholder: "Enter Mobile No",
                              padding: EdgeInsets.all(10),
                              style: TextStyle(fontSize: 20, letterSpacing: 2),
                              //textAlign: TextAlign.center,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CupertinoTextField(
                              maxLines: 4,
                              padding: EdgeInsets.all(10),
                              controller: _message,
                              placeholder: "Enter Your Message (Optional)",
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: CupertinoButton.filled(
                                  child: Text('SEND'),
                                  onPressed: () async {
                                    Uri url =
                                        Uri.parse(this.url(_phone.text, _message.text));
                                    await launchUrl(url,
                                        mode: LaunchMode.externalApplication);
                                  }),
                            ),
                           
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: CupertinoButton(
                                onPressed: () async {
                                  Uri url = Uri.parse("https://github.com/shivanuj13");
                                  await launchUrl(
                                    mode: LaunchMode.externalApplication,
                                    url);
                                },
                                child: Text('MADE WITH \u{2764} IN FLUTTER')),
                   )
                ],
              ),
             
            
          
        ));
  }
}
