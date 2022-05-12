import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/otp_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/main_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/pic_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/widgets/title_otp_widget.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class OTPPage extends StatelessWidget {
  final String phoneNumber;
  Registration? registration;
  String user = '';
  final bool isRegistration;
  final Configuration configuration;

  OTPPage({
    Key? key,
    required this.isRegistration,
    required this.phoneNumber,
    this.registration,
    required this.configuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<OtpBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OtpBloc>(),
      child: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is LoadedOtp) {
            openPageOTP(
                state.driver,
                state.configuration != null
                    ? state.configuration!
                    : configuration);
          }
        },
        builder: (context, state) {
          if (state is LoadingOtp) {
            return buildOtpWidget(context, true, null);
          } else if (state is ErrorOtp) {
            return buildOtpWidget(context, false, state.message);
          } else {
            return buildOtpWidget(context, false, null);
          }
        },
      ),
    );
  }

  Widget buildOtpWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
  ) {
    return Stack(
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
                backgroundTopCurveWidget(context, null),
                // Content
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: <Widget>[
                      // Greeting
                      TitleOTPWidget(phoneNumber: phoneNumber),
                      const SizedBox(height: 48),
                      // Login Controls
                      openPageControls(),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
                SizedBox(height: 120,),
                Text(
                  AppConstants.strCopyright +
                      ' ' +
                      AppConstants.strAppName,
                  style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24,),
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

  Widget openPageControls() {
    if (isRegistration) {
      return OtpControlsWidget(
        phoneNumber: user,
        registration: registration,
        isRegistration: isRegistration,
      );
    } else {
      return OtpControlsWidget(
        phoneNumber: phoneNumber,
        isRegistration: isRegistration,
      );
    }
  }

  void openPageOTP(Driver driver, Configuration configuration) {
    if (isRegistration) {
      Get.offAll(() => AddPicPage(
            isNextVehicle: true,
          ));
    } else {
      Get.offAll(() => MainPage(
            driver: driver,
            configuration: configuration,
          ));
    }
  }
}
