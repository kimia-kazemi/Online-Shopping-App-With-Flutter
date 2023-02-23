import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppo/models/map_address.dart';
import 'package:shoppo/services/get_reverse_geoCoding.dart';
import 'package:shoppo/utils/system_utils.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';
import '../models/routing_details_module.dart';

class GeoapifyApiRequests {
  static Future<dynamic> findCoordinateAddress(Position position) async {
    late String? placeAddress;
    Address pickupAddress = Address();
    GetController pickupController = Get.find<GetController>();

    String url =
        'https://api.geoapify.com/v1/geocode/reverse?lat=${position.latitude}&lon=${position.longitude}&apiKey=${geoApifyKey}';
    print(url);
    var response = await GetGeoCoding.getRequest(url);

    if (response != 'failed') {
      placeAddress = response['features'][0]['properties']['formatted'];
      pickupAddress.longitude = position.longitude;
      pickupAddress.latitude = position.latitude;
      print(position.latitude + position.longitude);
      print('theeeeer');
      pickupAddress.placeName = response['features'][0]['properties']['city'];
      pickupAddress.placeFromattedAddress = placeAddress;

      pickupController.updatePickupAddress(pickupAddress);
    }
    return placeAddress;
  }

  static Future<RoutingDetails?> getDirectionDetails(
      LatLng startposition, LatLng endposition) async {
    String url =
        'https://api.geoapify.com/v1/routing?waypoints=${startposition.latitude}%${startposition.longitude}%${endposition.latitude}%${endposition.latitude}&mode=drive&apiKey=$geoApifyKey';
    var response = await GetGeoCoding.getRequest(url);

    if (response != 'failed') {
      return null;
    }
    RoutingDetails routingDetails = RoutingDetails();
    routingDetails.distance = response['features'][0]['properties']['legs'][0]
        ['steps'][0]['distance'];
    routingDetails.duration =
        response['features'][0]['properties']['legs'][0]['steps'][0]['time'];
    return routingDetails;
  }
}
