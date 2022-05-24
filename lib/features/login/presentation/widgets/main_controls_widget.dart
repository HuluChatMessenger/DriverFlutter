import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class MainControlsWidget extends StatefulWidget {
  LatLng locationLatLng;
  bool isTraffic;
  final bool isFirst;

  MainControlsWidget(
      {Key? key,
      required this.isFirst,
      required this.locationLatLng,
      required this.isTraffic})
      : super(key: key);

  @override
  _MainControlsWidgetState createState() => _MainControlsWidgetState();
}

class _MainControlsWidgetState extends State<MainControlsWidget> {
  _MainControlsWidgetState() {
    Future.delayed(const Duration(microseconds: 5), () {
      if (widget.isFirst) {
        addMainLocationUpdates();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void addMainLocationUpdates() {
    BlocProvider.of<MainBloc>(context)
        .add(GetLocationUpdate(widget.locationLatLng, widget.isTraffic));
  }
}
