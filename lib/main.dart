import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppo/sotrage/card_info.dart';
import 'package:shoppo/theme/themes.dart';
import 'package:shoppo/sotrage/user_bio.dart';

import 'constatnts/navigation_page.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  await UserPreferences.init();
  await CardPreferences.init();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = UserPreferences?.getUser();

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
            home: NavigationPage(),
        ),
      ),
    );
  }


  }



