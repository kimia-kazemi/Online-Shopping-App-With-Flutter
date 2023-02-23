
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppo/models/map_address.dart';

class GetController extends GetxController {

  double _mapPadding = 0;
  double get mapPadding => _mapPadding;
  Address? pickupAddress;
  Address? destinationAddress;
  var formatteedAddress = "".obs;


  void changeValue() {
    _mapPadding = 260;

    update();
  }

  void updatePickupAddress(Address pickup){
     formatteedAddress.value = pickup.placeFromattedAddress!;
    pickupAddress=pickup;
    update();

  }

  void updateDestinationAddress(Address destination){
    destinationAddress=destination;
    update();

  }




}
