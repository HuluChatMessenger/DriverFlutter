import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapControlsWidget extends StatefulWidget {
  final double lat;
  final double long;

  MapControlsWidget(this.lat, this.long);

  @override
  State<MapControlsWidget> createState() => MapControlsWidgetState(lat: lat, long: long);
}

class MapControlsWidgetState extends State<MapControlsWidget> {
  final double lat;
  final double long;
  Completer<GoogleMapController> _controller = Completer();

  MapControlsWidgetState({required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition:
            CameraPosition(target: LatLng(lat, long), zoom: 14.4746),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
