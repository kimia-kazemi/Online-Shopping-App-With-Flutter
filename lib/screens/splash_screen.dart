import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoppo/screens/sign_up_in.dart';

import '../utils/system_utils.dart';

class ShSplashScreen extends StatefulWidget {
  static String tag = '/ShophopSplash';

  @override
  ShSplashScreenState createState() => ShSplashScreenState();
}

class ShSplashScreenState extends State<ShSplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    finish(context);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignInUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width + width * 0.4,
        child: Stack(
          children: <Widget>[
            Image.asset("assets/images/splash_bg.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover),
            Positioned(
              top: -width * 0.2,
              left: -width * 0.2,
              child: Container(
                width: width * 0.65,
                height: width * 0.65,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0XFF750550)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/Maybelline_logo_PNG4.png",
                      width: width * 0.3),
                  Text("Shoppo"),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: -width * 0.2,
                    right: -width * 0.2,
                    child: Container(
                      width: width * 0.65,
                      height: width * 0.65,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0XFF980F5A).withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset("assets/images/splash_img.png",
                    width: width * 0.5, height: width * 0.5))
          ],
        ),
      ),
    );
  }
}
