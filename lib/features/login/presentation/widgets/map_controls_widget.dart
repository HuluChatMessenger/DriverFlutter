import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

class MapControlsWidget extends StatefulWidget {
  LatLng? pickupLatLng;
  LatLng? destinationLatLng;
  bool isTraffic;
  bool isLocation;

  MapControlsWidget({this.pickupLatLng,
    this.destinationLatLng,
    required this.isTraffic,
    required this.isLocation});

  @override
  State<MapControlsWidget> createState() => MapControlsWidgetState();
}

class MapControlsWidgetState extends State<MapControlsWidget> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker>? _markers = <Marker>{};
  BitmapDescriptor? myMarker;

// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;

// for my custom marker pins
  BitmapDescriptor? pickupIcon;
  BitmapDescriptor? destinationIcon;

// the user's initial location and current location
// as it moves
  Position? currentLocation;

// a reference to the destination location
  Position? pickupLocation;

// a reference to the destination location
  Position? destinationLocation;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setLocation();
      generateMarkers();
      if (widget.destinationLatLng != null) {
        showPinsOnMap();
      }
    });


    // create an instance of Location
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    Geolocator.getPositionStream().listen((location) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = location;
      if (widget.destinationLatLng != null) {
      updatePinOnMap();}
    });

    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    setMarkerIcon();
    if (widget.isLocation) {
      setLocation();
      generateMarkers();
      if (widget.destinationLatLng != null) {
        showPinsOnMap();
      }
    }
    return Scaffold(
      body: GoogleMap(
        markers: _markers!,
        mapType: MapType.normal,
        initialCameraPosition:
        CameraPosition(target: LatLng(currentLocation!.latitude, currentLocation!.longitude), zoom: 14.4746),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          generateMarkers();

          if (widget.destinationLatLng != null) {
            showPinsOnMap();
          }
        },
        trafficEnabled: widget.isTraffic,
      ),
    );
  }

  void setMarkerIcon() async {
    myMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/images/marker.png');
  }

  void generateMarkers() {
    var localMarkers = <Marker>{};
    localMarkers.add(Marker(
        markerId: MarkerId('driverPin'),
        position: LatLng(
            currentLocation!.latitude, currentLocation!.longitude),
        icon: myMarker!));

    if (mounted) {
      setState(() {
        _markers = localMarkers;
      });
    }
  }

  void setLocation() async {
    await goToCurrentPosition();
  }

  Future<void> goToCurrentPosition() async {
    CameraPosition position = CameraPosition(
        bearing: AppConstants.cameraBearing,
        target: LatLng(
            currentLocation!.latitude, currentLocation!.longitude),
        tilt: AppConstants.cameraTilt,
        zoom: AppConstants.cameraZoom);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: AppConstants.cameraZoom,
      tilt: AppConstants.cameraTilt,
      bearing: AppConstants.cameraBearing,
      target: LatLng(currentLocation!.latitude,
          currentLocation!.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition = LatLng(currentLocation!.latitude,
          currentLocation!.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers?.removeWhere(
              (m) => m.markerId.value == "driverPin");
      _markers?.add(Marker(
          markerId: MarkerId("driverPin"),
          position: pinPosition, // updated position
          icon: pickupIcon!
      ));
    });
  }

  void setSourceAndDestinationIcons() async {
    pickupIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/marker_pickup.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/marker_drop_off.png');
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: false,
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    if (widget.destinationLatLng != null) {
      // hard-coded destination for this example
      
      destinationLocation = Position.fromMap({
        "latitude": widget.destinationLatLng?.latitude,
        "longitude": widget.destinationLatLng?.longitude
      });
      
      if (widget.pickupLatLng != null) {
        // hard-coded destination for this example
        pickupLocation = Position.fromMap({
          "latitude": widget.pickupLatLng?.latitude,
          "longitude": widget.pickupLatLng?.longitude
        });
      }
    }
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(pickupLocation!.latitude,
        pickupLocation!.longitude);
    // get a LatLng out of the LocationData object
    var destPosition = LatLng(destinationLocation!.latitude,
        destinationLocation!.longitude);
    // add the initial source location pin
    _markers?.add(Marker(
        markerId: MarkerId('pickUpPin'),
        position: pinPosition,
        icon: pickupIcon!
    ));
    // destination pin
    _markers?.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon!
    ));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolyLines();
  }

  void setPolyLines() async {
    PolylineResult? result = await polylinePoints?.getRouteBetweenCoordinates(
        AppConstants.apiKey,
        PointLatLng(pickupLocation!.latitude,
            pickupLocation!.longitude),
        PointLatLng(
            destinationLocation!.latitude,
            destinationLocation!.longitude));


    if (result?.points.isNotEmpty == true) {
      result?.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
            LatLng(point.latitude, point.longitude)
        );
      });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId('poly'),
            color: Colors.green,
            points: polylineCoordinates
        ));
      });
    }
  }
}
