import 'package:get/get.dart';

class Counter extends GetxController {
  int _counter = 0;

  int get counter => _counter;

  void incremet() {
    _counter++;
    update();
  }

  void decremet() {
    _counter = _counter - 1;

    update();
  }
}
