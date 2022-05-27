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
  LatLng? pickUpLatLng;
  LatLng? destinationLatLng;
  String balance = '0.0';
  bool isTraffic;

  MainCardControlsWidget(
      {Key? key,
      required this.driver,
      required this.isTraffic,
      this.pickUpLatLng,
      this.destinationLatLng,})
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
            color: Colors.white,
            minWidth: 48,
            height: 54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(54.0),
            ),
            child: Icon(
              Icons.traffic,
              color: widget.isTraffic ? Colors.green : Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
          child: MaterialButton(
            onPressed: () => addMainLocation(),
            child: const Icon(
              Icons.my_location,
              color: Colors.black,
            ),
            color: Colors.white,
            minWidth: 2,
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
            isTraffic: widget.isTraffic,
            pickUpLatLng: widget.pickUpLatLng,
            destinationLatLng: widget.destinationLatLng,
          ),
        ),
      ],
    );
  }

  void addMainLocation() {
    BlocProvider.of<MainBloc>(context)
        .add(GetLocation(widget.isTraffic, true, widget.pickUpLatLng, widget.destinationLatLng));
  }

  void addMainTraffic() {
    BlocProvider.of<MainBloc>(context)
        .add(GetTraffic(!widget.isTraffic, widget.pickUpLatLng, widget.destinationLatLng));
  }
}
