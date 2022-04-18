import 'package:flutter/material.dart';
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
          const Text(
            AppConstants.strOtpFirst,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          const Text(
            AppConstants.strOtpSecond,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          const Text(
            AppConstants.strOtpThird,
            style: TextStyle(
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
