import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapControlsWidget extends StatefulWidget {
  LatLng currentLatLng;
  bool isTraffic;
  bool isLocation;

  MapControlsWidget(
      {required this.currentLatLng,
      required this.isTraffic,
      required this.isLocation});

  @override
  State<MapControlsWidget> createState() => MapControlsWidgetState();
}

class MapControlsWidgetState extends State<MapControlsWidget> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      setLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLocation) {
      setLocation();
    }
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

  void setLocation() async {
    await goToCurrentPosition();
  }

  Future<void> goToCurrentPosition() async {
    CameraPosition position = CameraPosition(
        bearing: 192.8334901395799,
        target: widget.currentLatLng,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }
}
