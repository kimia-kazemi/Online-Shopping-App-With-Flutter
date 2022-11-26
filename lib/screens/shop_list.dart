import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppo/controllers/card_controller.dart';
import 'package:shoppo/models/cart_model.dart';
import 'package:shoppo/screens/order_summary.dart';
import 'package:shoppo/widgets/appbar_widger.dart';

import '../sotrage/card_info.dart';

class ShopList extends StatefulWidget {
  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  void initState() {
    super.initState();

    card = CardPreferences.getCard();
  }

  late CardModel card;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0XFF750550),
                isExtended: true,
                child: Icon(Icons.shopping_bag_outlined),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ShOrderSummaryScreen()));
                },
              ),
              appBar: buildAppBar(context),
              body: SafeArea(
                bottom: true,
                top: true,
                right: true,
                left: true,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: GetBuilder<CardController>(
                          init: CardController(),
                          builder: (cardController) {
                            return Column(children: <Widget>[
                              cardController.getItems.length == 0
                                  ? Center(
                                      child: Text(
                                      'Your shop list is empty 🙁',
                                      style: TextStyle(fontSize: 20),
                                    ))
                                  : Column(
                                      children: [
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                cardController.getItems.length,
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
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                cardController
                                                                        .getItems[
                                                                            index]
                                                                        .imageLink ??
                                                                    "",
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                                  return const Icon(
                                                                      Icons
                                                                          .error);
                                                                },
                                                              )),
                                                          flex: 3,
                                                          fit: FlexFit.tight,
                                                        ),
                                                        SizedBox(width: 10),
                                                        (cardController
                                                                    .getItems[
                                                                        index]
                                                                    .name ==
                                                                null)
                                                            ? Container()
                                                            : Flexible(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      cardController
                                                                              .getItems[index]
                                                                              .name ??
                                                                          "",
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'avenir',
                                                                          fontWeight: FontWeight
                                                                              .w800,
                                                                          fontSize:
                                                                              12),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                        '\$${cardController.getItems[index].price}',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .right,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontFamily:
                                                                                'avenir')),
                                                                    Container(
                                                                        height: width *
                                                                            0.08,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        width: width *
                                                                            0.20,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .transparent,
                                                                            borderRadius: BorderRadius.circular(
                                                                                4),
                                                                            border: Border
                                                                                .all()),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Expanded(
                                                                              child: Container(
                                                                                width: width * 0.20,
                                                                                height: width * 0.08,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), topLeft: Radius.circular(4))),
                                                                                child: IconButton(
                                                                                  icon: Icon(Icons.remove, size: 10),
                                                                                  onPressed: () {
                                                                                    cardController.minez(double.parse(cardController.getItems[index].price));
                                                                                    if (cardController.getItems[index].count == 1 || cardController.getItems[index].count < 1) {
                                                                                      cardController.getItems[index].count = 0;
                                                                                    } else {
                                                                                      cardController.getItems[index].count--;
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Text("${cardController.getItems[index].count.toString()}"),
                                                                            Expanded(
                                                                              child: Container(
                                                                                width: width * 0.20,
                                                                                height: width * 0.08,
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(4), topRight: Radius.circular(4))),
                                                                                child: IconButton(
                                                                                  icon: Icon(Icons.add, size: 10),
                                                                                  onPressed: () {
                                                                                    cardController.getItems[index].count++;

                                                                                    cardController.sum(double.parse(cardController.getItems[index].price ?? ""));
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          cardController
                                                                              .getItems
                                                                              .remove(index);
                                                                          cardController
                                                                              .update();
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.highlight_remove))
                                                                  ],
                                                                ),
                                                                flex: 2,
                                                                fit: FlexFit
                                                                    .tight,
                                                              ),
                                                        Flexible(
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_right_outlined,
                                                                size: 30,
                                                              ),
                                                              onPressed: () {}),
                                                          flex: 1,
                                                          fit: FlexFit.tight,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              16, 16, 16, 16),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1.0)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 10, 16, 10),
                                                child: Text("Payment Detail"),
                                              ),
                                              Divider(
                                                height: 1,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 10, 16, 10),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Text("Offer -"),
                                                        Text(
                                                          "offer not available",
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                            "Shipping Charge -"),
                                                        Text(
                                                          "Free",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text("Total Amount -"),
                                                        Text(
                                                          "\$${cardController.totalprice} ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                            ]);
                          })),
                ),
              ))),
    );
  }
}
