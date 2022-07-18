import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/message_provider.dart';
import 'package:send_whatsapp/provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
 

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _message = TextEditingController();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..repeat(reverse: true);

  late Animation<Offset> _animation =
      Tween<Offset>(begin: Offset.zero, end: Offset(0, 0.15))
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
 

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, widget) {
      return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            middle: const Text('MESSAGE TO ANYONE'),
            trailing: CupertinoSwitch(
                value: value.isDark,
                onChanged: (_) {
                  value.changeTheme();
                }),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SlideTransition(
                            position: _animation,
                            child: Image.asset(
                              "asset/image/logo-whatsapp.png",
                              width: 60,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              'SEND ON WHATSAPP',
                              style: TextStyle(
                                  color: Color(0xff075E54),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CupertinoTextField(
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(CupertinoIcons.phone),
                            ),
                           
                            maxLength: 10,
                            controller: _phone,
                            keyboardType: TextInputType.phone,
                            placeholder: "Enter Mobile No",
                            padding: const EdgeInsets.all(10),
                            style:
                                const TextStyle(fontSize: 20, letterSpacing: 3),
                            //textAlign: TextAlign.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoTheme.of(context)
                                        .primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          CupertinoTextField(
                          
                            maxLines: 3,
                            padding: const EdgeInsets.all(10),
                            controller: _message,
                            placeholder: "Enter Your Message (Optional)",
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoTheme.of(context)
                                        .primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child:  CupertinoButton.filled(
                                    child: const Text('SEND'),
                                    onPressed:
                                 
                                  () async {
                                     context.read<MessageProvider>().sendMessage(_phone.text,_message.text);
                                     
                                    })
                             
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoButton(
                        onPressed: () async {
                          Uri url = Uri.parse(
                              "https://github.com/shivanuj13/message-to-anyone");
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
            ),
          ));
    });
  }
}
