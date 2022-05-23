import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class MainControlsWidget extends StatefulWidget {
  LatLng locationLatLng;
  bool isTraffic;
  final bool isFirst;

  MainControlsWidget(
      {Key? key, required this.isFirst, required this.locationLatLng, required this.isTraffic})
      : super(key: key);

  @override
  _MainControlsWidgetState createState() =>
      _MainControlsWidgetState(isFirst: isFirst);
}

class _MainControlsWidgetState extends State<MainControlsWidget> {
  final bool isFirst;

  _MainControlsWidgetState({required this.isFirst}) {
    if (isFirst) {
      Future.delayed(const Duration(microseconds: 15), () {
        addMain();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void addMain() {
    BlocProvider.of<MainBloc>(context).add(GetMain(widget.locationLatLng, widget.isTraffic));
  }
}
