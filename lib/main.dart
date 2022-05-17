// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/LanguageTranslate.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  final sharedPreferences = await SharedPreferences.getInstance();

  String currentLanguageType = AppConstants.languageTypeAm;
  String currentLanguage =
      sharedPreferences.getString(AppConstants.prefKeyLanguage);

  currentLanguage ??= AppConstants.languageAm;

  if (currentLanguage == AppConstants.languageEn) {
    currentLanguageType = AppConstants.languageTypeEn;
  }

  print('LogHulu Launch: $currentLanguage === $currentLanguageType');

  runApp(GetMaterialApp(
    title: 'HuluTaxi',
    translations: LanguageTranslate(),
    locale: Locale(currentLanguage, currentLanguageType),
    fallbackLocale:
        const Locale(AppConstants.languageAm, AppConstants.languageTypeAm),
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.green,
      secondary: Colors.green.shade300,
    )),
    home: SplashPage(),
  ));
}
