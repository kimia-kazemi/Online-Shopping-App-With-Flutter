import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppo/constatnts/navigation_page.dart';
import 'package:shoppo/models/assets.dart';
import 'package:shoppo/design/email_model.dart';
import 'package:shoppo/screens/login_admin.dart';
import '../design/password_model.dart';
import '../models/sign_validate.dart';

enum AuthMod { SignUp, LogIn }

class SignInUp extends StatefulWidget {
  @override
  _SignInUp createState() => _SignInUp();
}

class _SignInUp extends State<SignInUp> {
  late SharedPreferences sharedPreferences;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isloading = false;

  get validator => null;
  final _auth = FirebaseAuth.instance;
  late DatabaseReference newdbref;

  @override
  void initState() {
    super.initState();
    registerUser();
    newdbref = FirebaseDatabase.instance.ref().child('User');

    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();

    super.dispose();
  }

  void login() async {
    try {
      final newUser = await _auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .catchError((err) {
        PlatformException thiserr = err;
        final snackbar = SnackBar(content: Text('${thiserr.message}'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
      if (newUser != null) {
        setState(() {
          _isloading = true;
        });
        DatabaseReference userref =
            FirebaseDatabase.instance.ref().child('User');
        userref.once().then((dataSnapshot) {
          if (dataSnapshot != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => NavigationPage()),
                (Route<dynamic> route) => false);
          }
        });
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      print('failed to login');
      print(e);
    }
  }

  void registerUser() async {
    try {
      final newUser = await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .catchError((err) {
        PlatformException thiserr = err;
        final snackbar = SnackBar(content: Text('${thiserr.message}'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
      if (newUser != null) {
        setState(() {
          _isloading = true;
        });

        Map<String, String> userinfo = {
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text
        };
        newdbref.push().set(userinfo);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationPage()),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      print('failed to sign up');

      print(e);
    }
  }

  AuthMod _authMod = AuthMod.LogIn;

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
          image: _authMod == AuthMod.SignUp
              ? AssetImage(Assets.page2)
              : AssetImage(Assets.page1),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _isloading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Color(0XFF980F5A),
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(children: [
                        _authMod == AuthMod.SignUp
                            ? Positioned(
                                top: 70,
                                right: 0.1,
                                child: Text(
                                  'Welcome to shoppo',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ))
                            : Positioned(
                                top: 120,
                                child: Text(
                                  'Welcome back',
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
                            _authMod == AuthMod.SignUp
                                ? UsernameFieldWidget(
                                    controller: usernameController,
                                  )
                                : Container(),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'haven\'t create a account yet?',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Switch to ${_authMod == AuthMod.LogIn ? 'Sign up' : 'Sign in'}',
                                        style:
                                            TextStyle(color: Color(0XFFb75ef2)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _authMod = _authMod == AuthMod.LogIn
                                              ? AuthMod.SignUp
                                              : AuthMod.LogIn;
                                        });
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Are Admin ?',
                                        style:
                                            TextStyle(color: Color(0XFFb75ef2)),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        loginAmin()),
                                                // AdminNavigationPage()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final form = formKey.currentState!;

                                    if (form.validate()) {
                                      _authMod == AuthMod.SignUp
                                          ? registerUser()
                                          : login();
                                    } else {
                                      print('fail');
                                    }
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
                                ),
                              ],
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
