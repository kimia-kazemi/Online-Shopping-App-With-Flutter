import 'package:flutter/cupertino.dart';
void finish(BuildContext context, [Object? result]) =>
    Navigator.pop(context, result);


String mapKey = 'AIzaSyD3f35dQJwlf2-bxqV1uJnoL7-EYD-EKuI';
String revUrl='https://api.geoapify.com/v1/geocode/reverse?lat=51.21709661403662&lon=6.7782883744862374&apiKey=YOUR_API_KEY';
String geoApifyKey='ce6de195c06f4375951ed16f2bc84c4b';

String autocompleteUrl='https://api.geoapify.com/v1/geocode/autocomplete?text=Mosco&apiKey=YOUR_API_KEY';
String placeApiUrl='https://api.geoapify.com/v2/place-details?id=id%3D514d368a517c511e40594bfd7b574ec84740f00103f90135335d1c00000000920313416e61746f6d697363686573204d757365756d&apiKey=YOUR_API_KEY';

String routingApiUrl ='https://api.geoapify.com/v1/routing?waypoints=50.96209827745463%2C4.414458883409225%7C50.429137079078345%2C5.00088081232559&mode=drive&apiKey=';