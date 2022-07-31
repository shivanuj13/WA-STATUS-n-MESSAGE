import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/message_provider.dart';
import 'package:send_whatsapp/provider/status_provider.dart';

import 'app.dart';
import 'provider/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeProvider.instance.initSharedPref();
  await ThemeProvider.instance.getTheme();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider.instance,
      ),
      ChangeNotifierProvider(
        create: (context) => MessageProvider(),
      ), 
      ChangeNotifierProvider(
        create: (context) => StatusProvider(),
      ),
    ], child: const MyApp());
  }
}
