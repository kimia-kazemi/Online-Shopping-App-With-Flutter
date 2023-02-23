import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppo/bindings/mybindings.dart';
import 'package:shoppo/screens/splash_screen.dart';
import 'package:shoppo/sotrage/card_info.dart';
import 'package:shoppo/theme/themes.dart';
import 'package:shoppo/sotrage/user_bio.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
const USE_DATABASE_EMULATOR = false;
// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file.
const emulatorPort = 9000;
// Android device emulators consider localhost of the host machine as 10.0.2.2
// so let's use that if running on Android.
final emulatorHost =
(!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
    ? '10.0.2.2'
    : 'localhost';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        FirebaseOptions(apiKey: 'AIzaSyD3f35dQJwlf2-bxqV1uJnoL7-EYD-EKuI', appId: '1:238394533594:ios:c1b4562a9a0f1976f4e7e3', messagingSenderId: '238394533594', projectId: 'onlineshopping-77935')



    //   FirebaseOptions(
    //   appId: '1:238394533594:ios:c1b4562a9a0f1976f4e7e3',
    //   messagingSenderId: '238394533594',
    //       databaseURL: 'https://onlineshopping-77935-default-rtdb.firebaseio.com',
    //       apiKey: 'AIzaSyD3f35dQJwlf2-bxqV1uJnoL7-EYD-EKuI', projectId: 'onlineshopping-77935'
    // )
  //   :
  //   FirebaseOptions(
  //   apiKey: "AIzaSyB5mTnqxqn2T4NO8pIqhLVgXsAZVn00lqY",
  //   appId: "1:238394533594:android:dbec9e6c81e354a5f4e7e3",
  // databaseURL: 'https://onlineshopping-77935-default-rtdb.firebaseio.com',
  // messagingSenderId: "238394533594",
  //   projectId: "onlineshopping-77935",
  // ),

  );

  if (USE_DATABASE_EMULATOR) {
    FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
  }

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
        builder: (context) => GetMaterialApp(
          initialBinding: MyBindins(),

          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: ShSplashScreen(),
          // home: NavigationPage(),
        ),
      ),
    );
  }
}
