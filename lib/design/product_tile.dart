import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppo/constatnts/kappbar.dart';
import 'package:shoppo/controllers/card_controller.dart';
import 'package:shoppo/models/cart_model.dart';
import 'package:shoppo/models/products.dart';
import 'package:shoppo/models/user_model.dart';
import 'package:shoppo/sotrage/card_info.dart';
import 'package:shoppo/widgets/numbeers_widget.dart';

import '../constatnts/search_widget.dart';
import '../screens/shop_list.dart';
import '../sotrage/user_bio.dart';

class ProductTile extends StatefulWidget {
  final Makeup product;
  ProductTile(this.product);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late int likedNumber = user.likedNumber;
  CardController cardController=  Get.put(CardController());
  late User user;
 late Makeup makeup;
  var favoridProducts = [];
  var shopList=[];
  late bool flag= true;
  late CardModel card;
  String query = '';
  late List<CardModel> cardlist = cardController.getItems;



  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
    card = CardPreferences.getCard();
  }


  @override
  Widget build(BuildContext context) {
    return
      Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child:
                 Image.network(widget.product.imageLink ?? "",
                   fit: BoxFit.cover,
                   errorBuilder:
                       (BuildContext context, Object exception, StackTrace? stackTrace) {
                     return const Icon(Icons.error);
                   },
                   )

                ),
                Positioned(
                  right: 0,
                  child: Obx(() => CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: widget.product.isFavorite.value
                          ? Icon(Icons.favorite_rounded)
                          : Icon(Icons.favorite_border),
                      onPressed: () {
                        widget.product.isFavorite.toggle();
                        if(widget.product.isFavorite.value && !(favoridProducts.contains(widget.product.id)) ) {
                          favoridProducts.add(widget.product.id);
                          setState(() {
                            print('lenght is');
                            print(favoridProducts.length);
                            likedNumber = user.likedNumber +1;
                            user =
                                user.copy(likedNumber: likedNumber);

                            UserPreferences.setUser(user);
                            flag = false;
                          });
                        }
                          // if ((favoridProducts.contains(widget.product.id)) && flag == true) {
                          //
                          // }
                          if(widget.product.isFavorite == false){
                            favoridProducts.remove(widget.product.id);
                            likedNumber = likedNumber-1;
                            user = user.copy(likedNumber: likedNumber);
                            UserPreferences.setUser(user);

                          }
                      },
                    ),
                  )),
                )
              ],
            ),
            SizedBox(height: 8),
            (widget.product.name == null) ? Container() :
            Text(
              widget.product.name ?? "",
              maxLines: 2,
              style:
              TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            if (widget.product.rating != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.product.rating.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text('\$${widget.product.price}',
                      style: TextStyle(fontSize: 20, fontFamily: 'avenir')),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline_outlined,size: 20,),
                  onPressed: () {
                    cardController.addItmes(widget.product);

                  }

                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

