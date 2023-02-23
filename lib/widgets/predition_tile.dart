import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppo/utils/system_utils.dart';
import '../controllers/controller.dart';
import '../models/map_address.dart';
import '../models/prediction_model.dart';
import '../services/get_reverse_geoCoding.dart';

class PredictionTile extends StatelessWidget {

  final Prediction? prediction;
  PredictionTile({this.prediction});
  GetController destinationController = Get.find<GetController>();

  void getPlaceDetails(String placeID, context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(title: Text('please wait ...'),)
    );
    String url = 'https://api.geoapify.com/v2/place-details?id=$placeID&apiKey=$geoApifyKey';
    var response = await GetGeoCoding.getRequest(url);
    Navigator.pop(context);

    if(response == 'failed'){
      return;
    }

    if(response != 'failed'){


      Address thisPlace = Address();
      thisPlace.placeName = response['features'][0]["properties"]["city"];
      thisPlace.placeid = placeID;
      thisPlace.latitude = response['features'][0]["properties"]["lat"];
      thisPlace.longitude = response['features'][0]["properties"]["lon"];
      print('this  is name');
      thisPlace.placeFromattedAddress = response['features'][0]["properties"]["formatted"];
      print(thisPlace.placeName);
      destinationController.updatePickupAddress(thisPlace);
      Navigator.pop(context, 'getDirection');
    }

  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: EdgeInsets.all(0),
      ),
      onPressed: (){
        getPlaceDetails(prediction!.placeid.toString(), context);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 8,),
            Row(
              children: <Widget>[
                Icon(Icons.location_on_outlined),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(prediction!.state.toString(), overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16,color: Colors.black),),
                      SizedBox(height: 2,),
                      Text(prediction!.formattedName.toString(), overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey),),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8,),

          ],
        ),
      ),
    );
  }
}