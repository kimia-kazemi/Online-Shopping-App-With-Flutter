import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shoppo/models/cart_model.dart';
import 'package:shoppo/models/products.dart';
import 'package:shoppo/provider/counter_provider.dart';
import 'package:shoppo/screens/detail_of_product.dart';
import 'package:shoppo/sotrage/card_info.dart';

import '../widgets/add_widget.dart';

class ProductTile extends StatefulWidget {
  final Makeup product;

  ProductTile(this.product);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late Makeup makeup;
  var favoridProducts = [];
  var shopList = [];
  late bool flag = true;
  late CardModel card;
  String query = '';
  var counterController = Get.put(Counter());

  @override
  void initState() {
    super.initState();
    card = CardPreferences.getCard();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    child: GestureDetector(
                      child: Image.network(
                        widget.product.imageLink ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailProduct(widget.product)));
                      },
                    )),
                Positioned(
                  right: 0,
                  child: Obx(
                    () => CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: widget.product.isFavorite.value
                            ? Icon(Icons.favorite_rounded)
                            : Icon(Icons.favorite_border),
                        onPressed: () {
                          widget.product.isFavorite.toggle();
                          print(widget.product.isFavorite);
                          //TODO
                          widget.product.isFavorite.value
                              ? counterController.incremet()
                              : counterController.decremet();
                          if (widget.product.isFavorite == false) {
                            favoridProducts.remove(widget.product.id);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            (widget.product.name == null)
                ? Container()
                : Text(
                    widget.product.name ?? "",
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: 'avenir', fontWeight: FontWeight.w800),
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
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('\$${widget.product.price}',
                      style: TextStyle(fontSize: 18, fontFamily: 'avenir')),
                  Quantitybtn(widget.product)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
