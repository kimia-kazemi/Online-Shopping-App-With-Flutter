import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/card_controller.dart';
import '../models/products.dart';

class Quantitybtn extends StatefulWidget {
  final Makeup product;

  Quantitybtn(this.product);

  @override
  QuantitybtnState createState() => QuantitybtnState();
}

class QuantitybtnState extends State<Quantitybtn> {
  CardController cardController = Get.put(CardController());

  bool visibility = false;
  var count = 1;
  var controller = Get.put(CardController());

  void _changed() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: visibility,
      child: Container(
        width: width * 0.15,
        height: width * 0.08,
        child: Text("Added"),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(4)),
      ),
      replacement: GestureDetector(
        onTap: () {
          _changed();
          controller.addItmes(widget.product, 0);
        },
        child: Container(
          width: width * 0.15,
          height: width * 0.08,
          child: Text("Add"),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
