import 'package:flutter/material.dart';

import '../../screens/about_screen.dart';
import '../../screens/help_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Divider(
              thickness: 2,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpPage()));
                },
                child: const Text('HELP')),
            const Divider(
              thickness: 2,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()));
                },
                child: const Text('ABOUT')),
            const Divider(
              thickness: 2,
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
