import 'package:flutter/material.dart';

class ValidateSignup extends StatefulWidget {
  @override
  _ValidateSignup createState() => _ValidateSignup();
}

class _ValidateSignup extends State<ValidateSignup> {
  @override
  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          hintText: 'Username',
          prefixIcon: Icon(Icons.person),
        ),
        textInputAction: TextInputAction.done,
      );
}
