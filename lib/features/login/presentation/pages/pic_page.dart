import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/vehicle_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/widgets.dart';

class AddPicPage extends StatelessWidget {
  Configuration? configuration;
  bool isBtnEnabled = false;
  final bool isNextVehicle;

  AddPicPage({
    Key? key,
    required this.isNextVehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
    ));
    return buildBody(context);
  }

  BlocProvider<PicBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PicBloc>(),
      child: BlocBuilder<PicBloc, PicState>(
        builder: (context, state) {
          if (state is LoadingPic) {
            return buildPicWidget(
              context,
              true,
              isBtnEnabled,
              null,
              state.selcetedPic,
            );
          } else if (state is ErrorPic) {
            return buildPicWidget(
              context,
              false,
              isBtnEnabled,
              state.message,
              state.selcetedPic,
            );
          } else if (state is LoadedPic) {
            isBtnEnabled = true;
            configuration = state.configuration;
            return buildPicWidget(
              context,
              false,
              isBtnEnabled,
              null,
              state.selcetedPic,
            );
          } else {
            isBtnEnabled = false;
            return buildPicWidget(
              context,
              false,
              isBtnEnabled,
              null,
              null,
            );
          }
        },
      ),
    );
  }

  Widget buildPicWidget(
    BuildContext context,
    bool isLoading,
    bool isBtnEnabled,
    String? errMsg,
    XFile? selectedPic,
  ) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text('strAddPhotoTitle'.tr),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                backgroundTopCurveWidget(context, null),
                // Content
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      PicControlsWidget(
                        selectedPic: selectedPic,
                      ),
                      const SizedBox(height: 48),
                      Text(
                        'strAddPhotoSub'.tr,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 64),
                      setBtnContinue(isBtnEnabled),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
  }

  Widget loading(bool isLoading) {
    if (isLoading) {
      return const LoadingWidget();
    } else {
      return Container();
    }
  }

  Widget error(String? errMsg) {
    if (errMsg != null && errMsg.isNotEmpty) {
      return DialogWidget(
        message: errMsg,
        isDismiss: true,
        typeDialog: AppConstants.dialogTypeErr,
      );
    } else {
      return Container();
    }
  }

  Widget setBtnContinue(bool isBtnEnabled) {
    return Positioned(
      left: 32,
      right: 32,
      bottom: 140,
      child: ButtonWidget(
        isBtnEnabled: isBtnEnabled,
        btnFunction: onBtnContinueClicked,
        btnText: 'strContinue'.tr,
      ),
    );
  }

  void onBtnContinueClicked() {
    if (isNextVehicle) {
      openPageVehicle();
    } else {
      openPageSplash();
    }
  }

  void openPageVehicle() {
    if (configuration != null) {
      Get.offAll(() => VehiclePage(
            configuration: configuration!,
          ));
    }
  }

  void openPageSplash() {
    Get.offAll(() => SplashPage());
  }
}
