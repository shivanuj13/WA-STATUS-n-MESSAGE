import 'package:flutter/material.dart';
import 'package:send_whatsapp/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/ui/screens/wrapper.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ThemeProvider.instance.getTheme().then((value) => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, widget) {
      return MaterialApp(
          home: const Wrapper(),
          theme: ThemeProvider.instance.isDark
              ? ThemeData(
                primaryColor:  const Color(0xff075E54),
                  colorScheme: const ColorScheme.dark(
                  surface: Color(0xff075E54),
                  primary: Color(0xff075E54),
                  onPrimary: Colors.white,
                  secondary: Color(0xff075E54),
                )):ThemeData(
                  primaryColor: const Color(0xff128C7E) ,
                  colorScheme: const ColorScheme.light(
                  surface: Color(0xff128C7E),
                  primary: Color(0xff128C7E),
                  onPrimary: Colors.white,
                  secondary: Color(0xff128C7E))
                ));
             
    });
  }
}
