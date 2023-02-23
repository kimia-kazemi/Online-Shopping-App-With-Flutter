import 'dart:async';
import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';
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
  GetController pickupController = Get.find<GetController>();

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
              pickupController.pickupAddress != null ?
              Flexible(
                child: Text(pickupController.pickupAddress!.placeName.toString(),
                    maxLines:2),
              ):
              Text(
                addressList[selectedPosition].address!,
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_city_rounded),
              pickupController.pickupAddress != null ?
              Flexible(
                child: Text(pickupController.pickupAddress!.placeName.toString(),
                    maxLines:2),
              ):
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
              pickupController.pickupAddress != null ?
              Flexible(
                child: Text(pickupController.pickupAddress!.placeFromattedAddress.toString(),
                    maxLines:2),
              ):
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
