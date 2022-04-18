// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/landing_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(GetMaterialApp(
    title: 'HuluTaxi',
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green,
          secondary: Colors.green.shade300,
        )),
    home: const SplashPage(),
  ));
}
