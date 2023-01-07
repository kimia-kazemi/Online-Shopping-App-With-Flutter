import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shoppo/screens/shop_list.dart';

UserAppBar(context) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Text('Shoppo',
        style: GoogleFonts.aclonica(
            fontSize: 25, color: Colors.black, fontStyle: FontStyle.italic)),
    actions: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopList()),
            );
          },
          icon: Icon(Icons.shopping_cart),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_alert),
        ),
      ),
    ],
  );
}

AdminAppBar(context) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Text('Admin Portal',
        style: GoogleFonts.aclonica(
            fontSize: 25, color: Colors.black, fontStyle: FontStyle.italic)),
    actions: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_alert),
        ),
      ),
    ],
  );
}
