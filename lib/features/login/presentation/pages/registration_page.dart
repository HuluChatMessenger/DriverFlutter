import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/landing_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/otp_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class RegistrationPage extends StatelessWidget {
  Registration? registrationSaved;
  bool? isQR;
  final bool isReferral;
  final Configuration configuration;

  RegistrationPage({
    Key? key,
    required this.isReferral,
    this.registrationSaved,
    this.isQR,
    required this.configuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<RegistrationBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegistrationBloc>(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is LoadedRegistration) {
            openPageOTP(state.registration);
          }
        },
        builder: (context, state) {
          if (state is LoadingRegistration) {
            registrationSaved = state.registration;
            return buildRegistrationWidget(
                context, true, null, state.registration);
          } else if (state is ErrorRegistration) {
            registrationSaved = state.registration;
            return buildRegistrationWidget(
                context, false, state.message, state.registration);
          } else {
            return buildRegistrationWidget(
                context, false, null, registrationSaved);
          }
        },
      ),
    );
  }

  Widget buildRegistrationWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    Registration? registration,
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
                    if (isQR == true) {
                      Get.offAll(() => LandingPage(
                            isReferral: isReferral,
                            configuration: configuration,
                          ));
                    } else {
                      Get.back();
                    }
                  },
                );
              },
            ),
            title: Text('strBack'.tr),
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
                      // Greeting
                      greetingsRegistrationWidget(context),
                      const SizedBox(height: 48),
                      // Login Controls
                      RegistrationControlsWidget(
                        isReferral: isReferral,
                        registration: registration,
                        configuration: configuration,
                      ),
                      const SizedBox(height: 64),
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

  void openPageOTP(Registration registration) {
    OTPPage otpPage = OTPPage(
      isRegistration: true,
      phoneNumber: registration.phoneNumber,
      registration: registration,
      configuration: configuration,
    );
    otpPage.user = registration.id.toString();
    Get.offAll(() => otpPage);
  }
}
