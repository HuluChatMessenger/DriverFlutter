import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/vehicle_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../widgets/widgets.dart';

class AddPicPage extends StatelessWidget {
  Configuration? configuration;
  AddPicPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<PicBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PicBloc>(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text(AppConstants.strAddPhotoTitle),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  backgroundTopCurveWidget(context),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        PicControlsWidget(),
                        const SizedBox(height: 48),
                        const Text(
                          AppConstants.strAddPhotoSub,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<PicBloc, PicState>(
            builder: (context, state) {
              if (state is LoadingPic) {
                return const LoadingWidget();
              } else if (state is ErrorPic) {
                return DialogWidget(
                  message: state.message,
                  isDismiss: true,
                  typeDialog: AppConstants.dialogTypeErr,
                );
              } else if (state is LoadedPic) {
                configuration = state.configuration;
                return setBtnContinue(true);
              } else {
                return setBtnContinue(false);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget setBtnContinue(bool isBtnEnabled) {
    return Positioned(
      left: 32,
      right: 32,
      bottom: 140,
      child: ButtonWidget(
        isBtnEnabled: isBtnEnabled,
        btnFunction: onBtnContinueClicked,
      ),
    );
  }

  void onBtnContinueClicked() {
    openPageVehicle();
  }

  void openPageVehicle() {
    if (configuration != null) {
      Get.offAll(() => VehiclePage(configuration: configuration!,));
    }
  }

// void openPageSplash() {
//   Get.offAll(() => const SplashPage());
// }
}
