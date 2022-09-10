import 'package:flutter/material.dart';

import 'package:shoppo/screens/shop_list.dart';

 kAppBar(context){



  return AppBar(

    iconTheme: IconThemeData(color: Colors.black),
    title: Text('Shoppo',style: TextStyle(color: Colors.black),),
    actions: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ShopList()),
          );

          },
          icon: Icon(Icons.shopping_cart),
          highlightColor: Colors.white,
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: (){
          },
          icon: Icon(Icons.add_alert),
          highlightColor: Colors.white,

        ),
      ),
    ],
  );
}


