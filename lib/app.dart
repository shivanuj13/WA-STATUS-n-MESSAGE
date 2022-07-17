import 'package:flutter/cupertino.dart';
import 'package:send_whatsapp/ui/screens/home_screen.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomePage(),
      theme: CupertinoThemeData.raw(
          Brightness.light,
          Color(0xff075E54),
          Color.fromARGB(255, 255, 255, 255),
          CupertinoTextThemeData(
              navTitleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
              actionTextStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16)),
          Color(0xff075E54),
          Color.fromARGB(255, 255, 255, 255)),
    );
  }
}
