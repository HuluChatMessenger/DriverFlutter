import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget backgroundWaitingWidget(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Lottie.asset(
      'assets/anim/WaitingCarAnimation.json',
      repeat: true,
      reverse: false,
      animate: true,
    ),
  );
}