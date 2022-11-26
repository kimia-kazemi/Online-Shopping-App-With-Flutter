import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/address_model.dart';

class AddressManagerScreen extends StatefulWidget {
  static String tag = '/AddressManagerScreen';

  @override
  AddressManagerScreenState createState() => AddressManagerScreenState();
}

class AddressManagerScreenState extends State<AddressManagerScreen> {
  List<ShAddressModel> addressList = [];
  int? selectedAddressIndex = 0;
  var primaryColor;
  var mIsLoading = true;
  var isLoaded = false;

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
    setState(() {
      mIsLoading = true;
    });
    var addresses = await loadAddresses();
    setState(() {
      addressList.clear();
      addressList.addAll(addresses);
      isLoaded = true;
      mIsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listView = ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 8, bottom: 8),
      itemBuilder: (item, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedAddressIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(
                  right: 8,
                  left: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                        value: index,
                        groupValue: selectedAddressIndex,
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedAddressIndex = value;
                          });
                        },
                        activeColor: Color(0XFF980F5A)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            addressList[index].first_name! +
                                " " +
                                addressList[index].last_name!,
                          ),
                          Text(
                            addressList[index].address!,
                          ),
                          Text(
                            addressList[index].city! +
                                "," +
                                addressList[index].state!,
                          ),
                          Text(
                            addressList[index].country! +
                                "," +
                                addressList[index].pinCode!,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            addressList[index].phone_number!,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      shrinkWrap: true,
      itemCount: addressList.length,
    );
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFF980F5A),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                //TODO: create the screen
                onPressed: null,
              )
            ],
            title: Text("Address Manager"),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              listView,
              MaterialButton(
                elevation: 0,
                padding: EdgeInsets.all(8),
                color: Color(0XFF980F5A),
                child: Text(
                  "Save",
                ),
                onPressed: () {
                  Navigator.pop(context, selectedAddressIndex);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
