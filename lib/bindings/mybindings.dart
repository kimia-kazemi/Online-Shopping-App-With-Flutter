import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../controllers/card_controller.dart';
import '../controllers/controller.dart';

class MyBindins implements Bindings {
  @override
  void dependencies() {
    Get.put(GetController());
    Get.put(CardController());
  }
}
