import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/otp_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class RegistrationPage extends StatelessWidget {
  final bool isReferral;

  const RegistrationPage({
    Key? key,
    required this.isReferral,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<RegistrationBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegistrationBloc>(),
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
                        greetingsRegistrationWidget(context),
                        const SizedBox(height: 48),
                        // Login Controls
                        RegistrationControlsWidget(
                          isReferral: isReferral,
                        ),
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is LoadedRegistration) {
                openPageOTP(state.registration.phoneNumber, state.registration.id.toString());
              }
            },
            builder: (context, state) {
              if (state is LoadingRegistration) {
                return const LoadingWidget();
              } else if (state is ErrorRegistration) {
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

  void openPageOTP(String phoneNumber, String user) {
    OTPPage otpPage = OTPPage(
      isRegistration: true,
      phoneNumber: phoneNumber,
    );
    otpPage.user = user;
    Get.to(() => otpPage);
  }
}
