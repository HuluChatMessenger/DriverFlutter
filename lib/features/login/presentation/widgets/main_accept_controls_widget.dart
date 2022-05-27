import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';

import '../bloc/bloc.dart';

class MainAcceptControlsWidget extends StatefulWidget {
  final Driver driver;
  LatLng? pickUpLatLng;
  LatLng? destinationLatLng;
  bool isTraffic;
  String estimatedPrice = '0.0';
  String timeLeft = '0';

  MainAcceptControlsWidget(
      {Key? key,
      required this.driver,
      required this.isTraffic,
      this.pickUpLatLng,
      this.destinationLatLng})
      : super(key: key);

  @override
  _MainAcceptControlsWidgetState createState() =>
      _MainAcceptControlsWidgetState();
}

class _MainAcceptControlsWidgetState extends State<MainAcceptControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        Center(
          child: Text(
            "${CommonUtils.formatCurrency(widget.estimatedPrice)} ${'strBirr'.tr}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
          child: MaterialButton(
            onPressed: () => addMainAccept(true),
            color: Colors.green,
            minWidth: MediaQuery.of(context).size.width - 100,
            height: 44,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'strAcceptTap'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.timeLeft,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
          child: MaterialButton(
            onPressed: () => addMainAccept(false),
            minWidth: MediaQuery.of(context).size.width - 100,
            height: 44,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'strDecline'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  void addMainAccept(bool isAccept) {
    BlocProvider.of<MainBloc>(context).add(GetMainAccept(isAccept,
        widget.isTraffic, widget.pickUpLatLng, widget.destinationLatLng));
  }
}
