import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/otp_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

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
        elevation: 0,
      ),
      body: const WebView(
        initialUrl: AppConstants.urlTerms,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
