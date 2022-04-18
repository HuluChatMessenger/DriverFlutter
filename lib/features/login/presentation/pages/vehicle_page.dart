import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/document_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Stack(
        children: <Widget>[
          Scaffold(
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
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Top Background
                  backgroundTopCurveWidget(context),
                  // Content
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        // Greeting
                        greetingsLoginWidget(context),
                        const SizedBox(height: 48),
                        // Login Controls
                        const LoginControlsWidget(),
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is EmptyLogin) {
                return Container();
              } else if (state is LoadingLogin) {
                return const LoadingWidget();
              } else if (state is LoadedLogin) {
                openPageDocuments();
                return Container();
              } else if (state is ErrorLogin) {
                return DialogWidget(
                  message: state.message,
                  isDismiss: true,
                  typeDialog: AppConstants.dialogTypeErr,
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  void openPageDocuments() {
    Get.offAll(() => const DocumentsPage());
  }

  void openPageSplash() {
    Get.offAll(() => const SplashPage());
  }
}
