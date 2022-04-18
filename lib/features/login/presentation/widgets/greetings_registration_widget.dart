import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

Widget greetingsRegistrationWidget(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        // Greeting
        Text(
          AppConstants.strGreetingFirst,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),
        // Title
        Text(
          AppConstants.strGreetingSecondRegistration,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}
