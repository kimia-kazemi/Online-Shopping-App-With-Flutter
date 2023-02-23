import 'package:flutter/material.dart';

class UsernameFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const UsernameFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _UsernameFieldWidget createState() => _UsernameFieldWidget();
}

class _UsernameFieldWidget extends State<UsernameFieldWidget> {
  @override
  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Username',
          prefixIcon: Icon(Icons.person),
        ),
        textInputAction: TextInputAction.done,
      );
}
