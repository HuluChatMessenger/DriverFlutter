import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget greetingsLoginWidget(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Greeting
        Text(
          'strGreetingFirst'.tr,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          'strGreetingSecondLogin'.tr,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 12),
        // Desc
        Text(
          'strGreetingThirdLogin'.tr,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}
