import 'package:flutter/material.dart';

class MyThemes {
  static final primary = Color(0XFF980F5A);
  static final primaryColor = Colors.red;
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0XFF413F42),
    primaryColorDark: primaryColor,
    appBarTheme: AppBarTheme(backgroundColor: Color(0XFF750550)),
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
    canvasColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0XFF484649),
      selectedItemColor: Color(0XFF980F5A),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade900,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.red,
    colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
}
