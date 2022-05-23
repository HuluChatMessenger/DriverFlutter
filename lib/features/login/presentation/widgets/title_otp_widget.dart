import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

class TitleOTPWidget extends StatelessWidget {
  final String phoneNumber;

  TitleOTPWidget({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'strOtpFirst'.tr,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Text(
            'strOtpSecond'.tr,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Text(
            'strOtpThird'.tr,
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Text(
            '+251$phoneNumber',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
