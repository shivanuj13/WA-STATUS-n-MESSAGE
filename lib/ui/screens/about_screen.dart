import 'package:flutter/material.dart';
import 'package:send_whatsapp/constants/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: Text(
                    'With this App, You can send WhatsApp Messages without saving any phone Number and Save WhatsApp Status directly to your Phone Gallery.',
                    style: text2,
                  ),
                ),
                const Divider(thickness: 2,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: Text(
                    'Any suggestions and bug reports are welcome.',
                    style: text2,
                  ),
                ),
                const Divider(thickness: 2,),
               
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Text('Connect with me :',style: text2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: TextButton(
                          onPressed: () async {
                            Uri url = Uri.parse(
                                "https://github.com/shivanuj13");
                            await launchUrl(
                                mode: LaunchMode.externalApplication, url);
                          },
                          child: const Text(
                            'GitHub',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                  ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: TextButton(
                          onPressed: () async {
                            Uri url = Uri.parse(
                                "https://www.linkedin.com/in/shivanuj13/");
                            await launchUrl(
                                mode: LaunchMode.externalApplication, url);
                          },
                          child: const Text(
                            'LinkedIn',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                ],),
                const Divider(thickness: 2,),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async {
                          Uri url = Uri.parse(
                              "https://github.com/shivanuj13/WA-STATUS-n-MESSAGE");
                          await launchUrl(
                              mode: LaunchMode.externalApplication, url);
                        },
                        child: const Text(
                          'MADE WITH \u{2764} IN FLUTTER',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            )));
  }
}
