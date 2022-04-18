import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
              onPressed: () {
                Get.back();
              },
            );
          },
        ),
        title: const Text(AppConstants.strBack),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Text('Main Page'),
        ),
      ),
    );
  }
}
