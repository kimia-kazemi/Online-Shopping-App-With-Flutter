import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppo/utils/system_utils.dart';
import 'package:shoppo/widgets/predition_tile.dart';

import '../controllers/controller.dart';
import '../models/prediction_model.dart';
import '../services/get_reverse_geoCoding.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var pickupTextController = TextEditingController();

  var destinationController = TextEditingController();

  GetController pickupController = Get.find<GetController>();

  var focusDestination = FocusNode();

  bool focused = false;

  void setFocus(BuildContext context) {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  List<Prediction> destinationPredictionList = [];

  void searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          'https://api.geoapify.com/v1/geocode/autocomplete?text=$placeName&apiKey=$geoApifyKey';
      var response = await GetGeoCoding.getRequest(url);

      if (response == 'failed') {
        return;
      }
      print('this  is autocomplete prinnnnnnnnnt');
      print(response);

      if (response != 'failed') {
        var predictionJson = response['features'];
        var thisList = (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();

        setState(() {
          destinationPredictionList = thisList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    pickupTextController.text =
        pickupController.pickupAddress?.placeName.toString() ?? " ";
    setFocus(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 210,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7)),
            ], color: Colors.white, borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Center(child: Text("set destination"))
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.circle,
                      size: 16,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: TextField(
                            controller: pickupTextController,
                            decoration: InputDecoration(
                                hintText: 'Pickup location',
                                fillColor: Colors.grey[100],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 16,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: TextField(
                            onChanged: (value) {
                              searchPlace(value);
                            },
                            controller: destinationController,
                            focusNode: focusDestination,
                            decoration: InputDecoration(
                                hintText: ' where is your place?',
                                fillColor: Colors.grey[100],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          (destinationPredictionList.length > 0)
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        prediction: destinationPredictionList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: destinationPredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
