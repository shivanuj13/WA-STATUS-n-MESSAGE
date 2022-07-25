import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_whatsapp/provider/status_provider.dart';
import 'package:send_whatsapp/provider/theme_provider.dart';
import 'package:send_whatsapp/ui/screens/status_screen.dart';
import 'package:send_whatsapp/ui/screens/home_screen.dart';
import 'package:send_whatsapp/ui/widgets/shared/drawer_widget.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final List<Widget> _pageList = [const HomePage(), const StatusPage()];
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        actions: [
          Consumer<ThemeProvider>(builder: (context, value, widget) {
            return Switch(
                value: value.isDark,
                onChanged: (isDark) {
                  value.changeTheme();
                });
          })
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            boxShadow: [BoxShadow(offset: Offset(0, 0), blurRadius: 6)]),
        child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if(index==1) {
                context.read<StatusProvider>().fetchMedia(context);
              }
              setState(() {
                _currentIndex = index;
              });
              _pageController.jumpToPage(_currentIndex);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: 'MESSAGE'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.photo_library), label: 'STATUS'),
            ]),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if(index==1) {
                context.read<StatusProvider>().fetchMedia(context);
              }
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pageList,
      ),
    );
  }
}
