import 'package:flutter/material.dart';

class MyThemes {
  static final primary = Color(0XFF9956A5);
  static final primaryColor = Colors.red;
  static final darkTheme = ThemeData(

    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    appBarTheme: AppBarTheme(backgroundColor: Color(0XFF9956A5)),
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,

    canvasColor: Colors.black,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade900,
        selectedItemColor: Color(0XFF9956A5),


    ),

    drawerTheme: DrawerThemeData(
      backgroundColor:Colors.grey.shade900,),



    //  ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.red,
    colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
}
