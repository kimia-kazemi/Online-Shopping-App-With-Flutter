import 'package:get/get.dart';
import 'package:shoppo/models/cart_model.dart';
import 'package:shoppo/models/products.dart';

class CardController extends GetxController {
  Map items = <dynamic, CardModel>{}.obs;
  var shopList = [].obs;

  double _totalprice = 0;

  double get totalprice => _totalprice;

  @override
  void onInit() {
    getItems;
    super.onInit();
  }

  void sum(double totalproce) {
    _totalprice += totalproce;
    update();
  }

  void minez(double totalproce) {
    _totalprice -= totalproce;

    update();
  }

  void addItmes(Makeup product, int count) {
    items.putIfAbsent(product.id!, () {
      print('adding items');
      print('the lenth is' + items.length.toString());

      return CardModel(
          id: product.id,
          brand: product.brand,
          name: product.name,
          price: product.price,
          count: count,
          imageLink: product.imageLink);
    });
  }

  List get getItems {
    return items.entries.map((e) {
      shopList.add(e.value);
      //update();

      return e.value;
    }).toList();
  }
}
