import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shoppo/models/cart_model.dart';
import 'package:shoppo/models/products.dart';

class CardController extends GetxController{

  Map<dynamic,CardModel> Items={};

  void addItmes (Makeup product){
  Items.putIfAbsent(product.id!, () {
    print('adding items');
    print('the lenth is'+Items.length.toString());

    return CardModel(

      id: product.id,
      brand: product.brand,
      name: product.name,
      price: product.price,
      imageLink: product.imageLink);});


  }

  List<CardModel> get getItems{
    return Items.entries.map((e) {
      return e.value;

    }).toList();
  }
}