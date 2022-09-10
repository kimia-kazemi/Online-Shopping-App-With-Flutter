import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:shoppo/screens/welcom.dart';

import '../screens/profile.dart';


class NavigationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }

}
class _NavigationPageState extends  State<NavigationPage>{

  List screens = [ WelcomeScreen(), ProfilePage()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return ThemeSwitchingArea(
      child:
      Builder(
        builder: (context) {
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: onTap,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.storefront_rounded),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: 'Profile')
                ]),
          );
        }
      ),
    );

  }

}