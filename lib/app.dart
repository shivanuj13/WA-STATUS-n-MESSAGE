import 'package:flutter/cupertino.dart';
import 'package:send_whatsapp/provider/theme_provider.dart';
import 'package:send_whatsapp/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ThemeProvider.instance.getTheme().then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, widget) {
      return CupertinoApp(
        home: HomePage(),
        theme: ThemeProvider.instance.isDark
            ? const CupertinoThemeData.raw(
                Brightness.dark,
                Color(0xff075E54),
                Color.fromARGB(255, 255, 255, 255),
                CupertinoTextThemeData(
                    navTitleTextStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16),
                    actionTextStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16)),
                Color(0xff075E54),
                Color.fromARGB(255, 16, 24, 24),
              )
            : const CupertinoThemeData.raw(
                Brightness.light,
                Color(0xff128C7E),
                Color.fromARGB(255, 255, 255, 255),
                CupertinoTextThemeData(
                    navTitleTextStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16),
                    actionTextStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16)),
                Color(0xff128C7E),
                Color.fromARGB(255, 255, 255, 255)),
      );
    });
  }
}
