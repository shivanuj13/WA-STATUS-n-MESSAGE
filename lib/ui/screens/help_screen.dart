import 'package:flutter/material.dart';
import 'package:send_whatsapp/constants/text_style.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(padding: const EdgeInsets.all(18),child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
             padding: const EdgeInsets.symmetric(vertical:8.0),
             child: Text('Message',style: text1(context),),
           ),
           Text('1.  Enter Mobile number of receiver.',style: text2,),
           Text('2.  Message field is optional.',style: text2,),
           Text('3.  Hit the SEND button.',style: text2,),
           Text('4.  You can add media from WhatsApp after that.',style: text2,),
           Padding(
             padding: const EdgeInsets.symmetric(vertical:8.0),
             child: Text('Status',style:text1(context)),
           ),
           Text('1.  Tap on \u{2193} icon to Save any Photo or Video.',style: text2,),
           Text('2.  Tap on \u{25B6} icon to Play any Video.',style: text2,),
         
        ],
      ))
    );
  }
}