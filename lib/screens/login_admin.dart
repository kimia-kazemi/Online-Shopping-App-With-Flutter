import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppo/constatnts/admin_navigation_page.dart';
import 'package:shoppo/constatnts/navigation_page.dart';
import 'package:shoppo/models/assets.dart';
import 'package:shoppo/design/email_model.dart';
import 'package:shoppo/models/sign_validate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../design/password_model.dart';

enum AuthMod { SignUp, LogIn }

class loginAmin extends StatefulWidget {
  @override
  _loginAmin createState() => _loginAmin();
}

class _loginAmin extends State<loginAmin> {
  late SharedPreferences sharedPreferences;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isloading = false;

  get validator => null;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  auth(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    String url = "Your URL";
    var jsonResponse;
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isloading = false;
        });
        //set sharedPreferences that app will remember not to navigate signIn page when app restarts
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isloading = false;
      });
      print(response.body);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Assets.page3),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _isloading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(children: [
                        Positioned(
                            top: 70,
                            right: 0.1,
                            child: Text(
                              'Welcome back admin',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ))
                      ]),
                    ),
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            EmailFieldWidget(controller: emailController),
                            SizedBox(height: 10),
                            PassworFieldWidget(
                                passwordcontroller: passwordController),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                final form = formKey.currentState!;
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AdminNavigationPage()),
                                    // AdminNavigationPage()),
                                    (Route<dynamic> route) => false);

                                // if (form.validate()) {
                                //   final email = emailController.text;
                                //   final password = passwordController.text;
                                //   setState(() {
                                //     _isloading = true;
                                //   });
                                //   auth(email, password);
                                // }
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFF9D1D1),
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(24),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    ));
  }
}
