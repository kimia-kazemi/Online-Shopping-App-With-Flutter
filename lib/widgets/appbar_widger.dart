import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
