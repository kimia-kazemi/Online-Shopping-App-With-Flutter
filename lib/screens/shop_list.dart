import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppo/controllers/card_controller.dart';
import 'package:shoppo/models/cart_model.dart';
import 'package:shoppo/models/products.dart';
import 'package:shoppo/widgets/appbar_widger.dart';

import '../design/product_tile.dart';
import '../sotrage/card_info.dart';




class  ShopList extends StatefulWidget {
  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  void initState() {
    super.initState();

    card = CardPreferences.getCard();
  }
  late CardModel card ;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) =>  Scaffold(
              appBar: buildAppBar(context),
              body: SafeArea(
                bottom: true,
                top: true,
                right: true,
                left: true,
                child: Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child:
                      Column(
                        children: <Widget>[
                          Text('Your Shop List'),
                         GetBuilder<CardController>(builder: (cardController){
                           return ListView.builder(
                               physics: NeverScrollableScrollPhysics(),
                               shrinkWrap: true,
                               itemCount: cardController.getItems.length,
                               itemBuilder: (context, index) {
                                 return Column(
                                   children: <Widget>[
                                     Card(
                                       elevation: 50,
                                       child: Row(
                                         children: [
                                           Flexible(
                                             child: Container(
                                                 height: 180,
                                                 width: 50,
                                                 clipBehavior: Clip.antiAlias,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius
                                                       .circular(4),
                                                 ),
                                                 child:
                                                 Image.network(
                                                   cardController.getItems[index].imageLink ??
                                                       "",
                                                   fit: BoxFit.cover,
                                                   errorBuilder:
                                                       (BuildContext context,
                                                       Object exception,
                                                       StackTrace? stackTrace) {
                                                     return const Icon(
                                                         Icons.error);
                                                   },
                                                 )

                                             ),
                                             flex: 3,
                                             fit: FlexFit.tight,
                                           ),
                                           SizedBox(width: 10),
                                           (cardController.getItems[index].name! == null)
                                               ? Container()
                                               :
                                           Flexible(
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment
                                                   .end,
                                               //Center Row contents horizontally,
                                               children: [
                                                 Text(
                                                   cardController.getItems[index].name  ?? "",
                                                   maxLines: 2,
                                                   style:
                                                   TextStyle(
                                                       fontFamily: 'avenir',
                                                       fontWeight: FontWeight
                                                           .w800,
                                                       fontSize: 12),
                                                   overflow: TextOverflow
                                                       .ellipsis,
                                                 ),
                                                 SizedBox(height: 20,),
                                                 Text('\$${cardController.getItems[index].price}',
                                                     textAlign: TextAlign.right,
                                                     style: TextStyle(
                                                         fontSize: 20,
                                                         fontFamily: 'avenir')),

                                               ],
                                             ),
                                             flex: 2,
                                             fit: FlexFit.tight,

                                           ),
                                           Flexible(child: IconButton(
                                               icon: Icon(
                                                 Icons.arrow_right_outlined,
                                                 size: 30,),
                                               onPressed: () {

                                               }

                                           ),
                                             flex: 1,
                                             fit: FlexFit.tight,

                                           )
                                         ],
                                       ),
                                     )
                                   ],
                                 );
                               });
                         }

                         )
                        ],
                      )
                  ),
                ),
              )

          )
      ),
    );
  }
}

