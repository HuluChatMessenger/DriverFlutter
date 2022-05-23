import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/presentation/widgets/main_online_controls_widget.dart';

import '../bloc/bloc.dart';
import 'widgets.dart';

class MainCardControlsWidget extends StatefulWidget {
  final Driver driver;
  String balance = '0.0';
  bool isTraffic;
  LatLng locationLatLng;

  MainCardControlsWidget(
      {Key? key,
      required this.driver,
      required this.locationLatLng,
      required this.isTraffic})
      : super(key: key);

  @override
  _MainCardControlsWidgetState createState() => _MainCardControlsWidgetState();
}

class _MainCardControlsWidgetState extends State<MainCardControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 24.0),
          child: MaterialButton(
            onPressed: () => addMainTraffic(),
            child: const Icon(
              Icons.traffic,
              color: Colors.black,
            ),
            color: Colors.white,
            minWidth: 48,
            height: 54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(54.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
          child: MaterialButton(
            onPressed: () => addMain(),
            child: const Icon(
              Icons.my_location,
              color: Colors.black,
            ),
            color: Colors.white,
            minWidth: 48,
            height: 54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(54.0),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(24, 24),
                topRight: Radius.elliptical(24, 24)),
            color: Colors.white,
          ),
          child: MainOnlineControlsWidget(
            driver: widget.driver,
            locationLatLng: widget.locationLatLng,
            isTraffic: widget.isTraffic,
          ),
        ),
      ],
    );
  }

  void addMain() {
    BlocProvider.of<MainBloc>(context)
        .add(GetMain(widget.locationLatLng, widget.isTraffic));
  }

  void addMainTraffic() {
    BlocProvider.of<MainBloc>(context)
        .add(GetMain(widget.locationLatLng, !widget.isTraffic));
  }
}
