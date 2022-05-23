import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapControlsWidget extends StatefulWidget {
  LatLng currentLatLng;
  bool isTraffic;

  MapControlsWidget({required this.currentLatLng, required this.isTraffic});

  @override
  State<MapControlsWidget> createState() => MapControlsWidgetState();
}

class MapControlsWidgetState extends State<MapControlsWidget> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      LatLng latLng = widget.currentLatLng;
      widget.currentLatLng = latLng;
    });

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: widget.currentLatLng, zoom: 14.4746),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        trafficEnabled: widget.isTraffic,
      ),
    );
  }

  Future<void> _goToTheLake() async {
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
