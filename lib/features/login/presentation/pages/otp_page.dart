import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
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

  OTPPage({
    Key? key,
    required this.isRegistration,
    required this.phoneNumber,
    this.registration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<OtpBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OtpBloc>(),
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
                ],
              ),
            ),
          ),
          BlocConsumer<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state is LoadedOtp) {
                openPageOTP();
              }
            },
            builder: (context, state) {
              if (state is LoadingOtp) {
                return const LoadingWidget();
              } else if (state is ErrorOtp) {
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

  void openPageOTP() {
    if (isRegistration) {
      Get.offAll(() => AddPicPage());
    } else {
      Get.offAll(() => const MainPage());
    }
  }
}
