import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/message_provider.dart';
import 'package:send_whatsapp/provider/theme_provider.dart';
import 'package:send_whatsapp/ui/widgets/home_screen_widgets/animation_widget.dart';
import 'package:send_whatsapp/ui/widgets/home_screen_widgets/message_text_field.dart';
import 'package:send_whatsapp/ui/widgets/home_screen_widgets/phone_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
  {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _message = TextEditingController();
  bool switchValue=false;
  

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, widget) {
      return SafeArea(
        child: SingleChildScrollView(
          
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const AnimatedLogoWidget(),
                 Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'SEND ON WHATSAPP',
                    style: TextStyle(
                        color:Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              PhoneTextField(phone: _phone),
                const SizedBox(
                  height: 18,
                ),
                MessageTextField(message: _message),
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width/2,
                          50,
                        ),
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 10,
                      ),
                        child: const Text('SEND'),
                        onPressed: () async {
                          context
                              .read<MessageProvider>()
                              .sendMessage(_phone.text, _message.text);
                        })),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal:5),
                        //   child: SwitchListTile(
                        //     activeColor: Theme.of(context).primaryColor,
                        //     title:  Text('Are you using WhatsApp Business?',style: text3(context),),
                        //     value: switchValue, onChanged: (value) {
                        //     setState(() {
                        //       switchValue=value;
                        //     });
                        //   }),
                        // )
              ],
            ),
          ),
        ),
      );
    });
  }
}
