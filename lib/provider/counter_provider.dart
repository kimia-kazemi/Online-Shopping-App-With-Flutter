import 'package:get/get.dart';

class Counter extends GetxController {
  int _counter = 0;

  int get counter => _counter;
  String _productChangedName = '';

  String get productChangedName => _productChangedName;

  void changeName(String name) {
    this._productChangedName = name;
    update();
  }

  void incremet() {
    _counter++;
    update();
  }

  void decremet() {
    _counter = _counter - 1;

    update();
  }
}
