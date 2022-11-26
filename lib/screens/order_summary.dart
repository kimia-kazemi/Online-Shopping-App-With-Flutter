import 'dart:async';
import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../design/address_manager.dart';
import '../models/address_model.dart';

class ShOrderSummaryScreen extends StatefulWidget {
  static String tag = '/ShOrderSummaryScreen';

  @override
  ShOrderSummaryScreenState createState() => ShOrderSummaryScreenState();
}

class ShOrderSummaryScreenState extends State<ShOrderSummaryScreen> {
  // List<ShProduct> list = [];
  List<ShAddressModel> addressList = [];
  var selectedPosition = 0;
  List<String> images = [];
  var currentIndex = 0;
  Timer? timer;
  var isLoaded = false;

  //
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<String> loadContentAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<List<ShAddressModel>> loadAddresses() async {
    String jsonString = await loadContentAsset('assets/data/address.json');
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List)
        .map((i) => ShAddressModel.fromJson(i))
        .toList();
  }

  fetchData() async {
    // var products = await loadCartProducts();
    var addresses = await loadAddresses();
    //var banner = await loadBanners();
    setState(() {
      // list.clear();
      // list.addAll(products);
      addressList.clear();
      addressList.addAll(addresses);
      // images.clear();
      // images.addAll(banner);
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  void startTimer() {
    if (timer != null) {
      return;
    }
    timer = new Timer.periodic(new Duration(seconds: 5), (time) {
      setState(() {
        if (currentIndex == images.length - 1) {
          currentIndex = 0;
        } else {
          currentIndex = currentIndex + 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    // var cartList = isLoaded
    //     ? ListView.builder(
    //     scrollDirection: Axis.vertical,
    //     itemCount: list.length,
    //     shrinkWrap: true,
    //     padding: EdgeInsets.only(bottom: 8),
    //     physics: NeverScrollableScrollPhysics(),
    //     itemBuilder: (context, index) {
    //       return Container(
    //         margin: EdgeInsets.only(left: 8, right: 8, top: 8),
    //         child: IntrinsicHeight(
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: <Widget>[
    //               Image.asset(
    //                 "images/shophop/img/products" + list[index].images![0].src!,
    //                 width: width * 0.25,
    //                 height: width * 0.3,
    //                 fit: BoxFit.fill,
    //               ),
    //               Expanded(
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.max,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: <Widget>[
    //                           SizedBox(
    //                             height: spacing_standard,
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(left: 16.0),
    //                             child: text(list[index].name, textColor: sh_textColorPrimary, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(left: 16.0, top: spacing_control),
    //                             child: Row(
    //                               children: <Widget>[
    //                                 Container(
    //                                   decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
    //                                   padding: EdgeInsets.all(spacing_control_half),
    //                                   child: Icon(
    //                                     Icons.done,
    //                                     color: sh_white,
    //                                     size: 12,
    //                                   ),
    //                                 ),
    //                                 SizedBox(
    //                                   width: spacing_standard,
    //                                 ),
    //                                 text("M", textColor: sh_textColorPrimary, fontSize: textSizeMedium),
    //                                 SizedBox(
    //                                   width: spacing_standard,
    //                                 ),
    //                                 Container(
    //                                   padding: EdgeInsets.fromLTRB(spacing_standard, 1, spacing_standard, 1),
    //                                   decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
    //                                   child: Row(
    //                                     mainAxisAlignment: MainAxisAlignment.center,
    //                                     crossAxisAlignment: CrossAxisAlignment.center,
    //                                     children: <Widget>[
    //                                       text("Qty: 5", textColor: sh_textColorPrimary, fontSize: textSizeSMedium),
    //                                       Icon(
    //                                         Icons.arrow_drop_down,
    //                                         color: sh_textColorPrimary,
    //                                         size: 16,
    //                                       )
    //                                     ],
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(left: 16.0),
    //                             child: Row(
    //                               crossAxisAlignment: CrossAxisAlignment.end,
    //                               children: <Widget>[
    //                                 text(list[index].on_sale! ? list[index].sale_price.toString().toCurrencyFormat() : list[index].price.toString().toCurrencyFormat(),
    //                                     textColor: sh_colorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),
    //                                 SizedBox(
    //                                   width: spacing_control,
    //                                 ),
    //                                 Padding(
    //                                   padding: const EdgeInsets.only(bottom: 3.0),
    //                                   child: Text(
    //                                     list[index].regular_price.toString().toCurrencyFormat()!,
    //                                     style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSMedium, decoration: TextDecoration.lineThrough),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //       // return Chats(mListings[index], index);
    //     })
    //     : Container();
    var address = Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Icon(Icons.perm_contact_calendar_outlined),
              Text(
                addressList[selectedPosition].first_name! +
                    " " +
                    addressList[selectedPosition].last_name!,
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.map_outlined),
              Text(
                addressList[selectedPosition].address!,
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_city_rounded),
              Text(
                addressList[selectedPosition].city! +
                    "," +
                    addressList[selectedPosition].state!,
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.flag_outlined),
              Text(
                addressList[selectedPosition].country! +
                    "," +
                    addressList[selectedPosition].pinCode!,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(Icons.local_phone_outlined),
              Text(
                addressList[selectedPosition].phone_number!,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              padding: EdgeInsets.all(10),
              child: Text(
                "Change Address",
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40.0),
                  side: BorderSide(width: 1)),
              onPressed: () async {
                var pos = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AddressManagerScreen())) ??
                    selectedPosition;
                setState(() {
                  selectedPosition = pos;
                });
              },
            ),
          )
        ],
      ),
    );
    var bottomButtons = Container(
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 3))
      ], color: Color(0XFF980F5A)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "\$70",
                ),
                Text("See Price Detail"),
                //TODO: add drop pop
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              child: Container(
                child: Text(
                  "Continue",
                ),
                alignment: Alignment.center,
                height: double.infinity,
              ),
              onTap: () {
                //  ShPaymentsScreen().launch(context);
              },
            ),
          )
        ],
      ),
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFF980F5A),
            title: Text("Order summary"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Column(
                children: <Widget>[
                  isLoaded ? address : Container(),
                  // cartList,
                  images.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.red, width: 0.5)),
                          margin: const EdgeInsets.all(16),
                          child: Image.asset(
                            images[currentIndex],
                            width: double.infinity,
                            height: width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            child: bottomButtons,
          ),
        ),
      ),
    );
  }
}
