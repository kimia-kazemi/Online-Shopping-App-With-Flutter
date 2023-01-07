import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:shoppo/screens/admin_portal.dart';
import 'package:shoppo/screens/report_screen.dart';

class AdminNavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminNavigationPage();
  }
}

class _AdminNavigationPage extends State<AdminNavigationPage> {
  List screens = [AdminPortal(), ReportScreen()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.storefront_rounded), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.document_scanner_rounded),
                    label: 'Reports')
              ]),
        );
      }),
    );
  }
}
