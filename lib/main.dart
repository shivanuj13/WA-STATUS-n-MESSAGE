import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/message_provider.dart';

import 'app.dart';
import 'provider/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeProvider.instance.initSharedPref();
  await ThemeProvider.instance.getTheme();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
      create: (context) => ThemeProvider.instance,),
      ChangeNotifierProvider(
      create: (context) => MessageProvider(),),
       
    
      ],

       child: MyApp()
  ));
}
