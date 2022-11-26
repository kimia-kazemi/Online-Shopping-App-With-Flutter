import 'package:flutter/material.dart';

class PassworFieldWidget extends StatefulWidget {
  final TextEditingController passwordcontroller;

  const PassworFieldWidget({
    Key? key,
    required this.passwordcontroller,
  }) : super(key: key);

  @override
  _PassworFieldWidget createState() => _PassworFieldWidget();
}

class _PassworFieldWidget extends State<PassworFieldWidget> {
  @override
  void initState() {
    super.initState();

    widget.passwordcontroller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.passwordcontroller.removeListener(onListen);

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.passwordcontroller,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: widget.passwordcontroller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => widget.passwordcontroller.clear(),
                ),
        ),
        obscureText: true,

        // validator: (password) => password != null &&  !passwordValidator(password)
        //     ? 'Enter a valid password'
        //     : null,

        validator: (password) {
          if (password!.trim().isEmpty) {
            return 'Password is required';
          } else
            return " ";
        },
      );

  passwordValidator(password) {
    return Text('entered');
  }
}
