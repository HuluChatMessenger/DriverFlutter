// @dart=2.9

import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/login_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HuluTaxi',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green,
            secondary: Colors.green.shade300,
          )),
      home: const LoginPage(),
    );
  }
}
