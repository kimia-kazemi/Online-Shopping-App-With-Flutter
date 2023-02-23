// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppo/controllers/controller.dart';
import 'package:shoppo/screens/search_screen.dart';
import 'package:shoppo/services/get_cordinate_address.dart';
import 'package:shoppo/services/get_reverse_geoCoding.dart';

import '../models/map_address.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  GetController paddingController = Get.find<GetController>();
  Geolocator geoLcator = Geolocator();
  late Position currentPosition;
  GetController pickupController = Get.find<GetController>();



  void  getCurrentLocation() async{
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    currentPosition =  pos;
    LatLng latLng = LatLng(pos.latitude, pos.longitude);
    CameraPosition camera  =  CameraPosition(target: latLng,zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(camera));
    print('getting address');
    String? address =  GeoapifyApiRequests.findCoordinateAddress(pos)?.toString() ?? '';
    print(address);
  }


  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
        ],
      ),
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: 260),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (controller){
              mapController=controller;
              setState(() {
                getCurrentLocation();

              });
            },


          ),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7)
                    ),
                  ],
                    color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15),

                  )
                ),
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24,vertical: 18),
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Text('where do you want to go?'),
                      SizedBox(height: 25,),
                      GestureDetector(
                        onTap:(){ Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SearchScreen()));} ,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(12),

                            child: Row(children: [
                              Icon(Icons.search),
                              SizedBox(width: 10,),
                              Text('Enter destination')
                            ],),
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.7,0.7)
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4)
                              )

                          ),
                      ),
                      SizedBox(height: 22),
                      Row(
                        children: [
                          Icon(Icons.home_outlined),
                          SizedBox(width: 12,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pickupController.pickupAddress != null
                                    ? Obx(() => Text(
                                    pickupController.formatteedAddress!
                                        .value
                                        .toString(),
                                    maxLines: 2))
                                    : Text('Add home'),
                                // Text((pickupController.pickupAddress != null)? pickupController.pickupAddress.placeName :'Add home')
                              ],
                            ),
                          )
                        ],
                      )



                    ],
                  ),
                ) ,
              ))
        ],
      ),
    );
  }
}
