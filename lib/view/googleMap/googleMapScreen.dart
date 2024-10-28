import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';

class GoogleMapScreen extends StatefulWidget {
  List coordinates;
  String shopName;
  GoogleMapScreen({required this.coordinates,required this.shopName, Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}
class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  void initState() {
    currentmarker();
    // TODO: implement initState
    super.initState();
  }
  
  Set<Marker> markersList = {};
  currentmarker() {
    markersList.clear(); // Clear existing markers
    markersList.add(Marker(
      markerId: const MarkerId("0"),
      position: LatLng(widget.coordinates[0], widget.coordinates[1]),
      infoWindow:  InfoWindow(title: widget.shopName),

    ));
  }

  @override
  Widget build(BuildContext context) {
    print("coordinates: ${widget.coordinates} ${widget.shopName}");
    return Scaffold(
      appBar: AppBar(title: text("Your Location",fontSize: textSizeLargeMedium,fontWeight: FontWeight.w600),),
      body: Stack(
        children: [
          // GoogleMap widget to display the map
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.coordinates[0], widget.coordinates[1]),
                zoom: 18,
                ),
                mapType: MapType.normal,
            markers: markersList,
            onMapCreated: (GoogleMapController controller) {},
          ),
        ],
      ),
    );
  }
}
