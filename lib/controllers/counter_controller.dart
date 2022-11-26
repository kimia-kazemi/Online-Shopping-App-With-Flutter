import 'package:get/get.dart';
class CounterController extends GetxController{

  int counter = 0;
  double _totalprice = 0;

  double get totalprice => _totalprice;

  void increment() {
    counter++;
    update();
  }

  void decrement() {
    counter--;
    update();
  }

  void sum(double totalproce) {
    _totalprice += totalproce;
    update();
  }
}