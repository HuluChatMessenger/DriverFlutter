import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

Widget backgroundLandingWidget(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Image.asset('assets/images/landing_1.png'),
  );
}