import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/otp_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
    ));
    return buildBody(context);
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoadedLogin) {
            openPageOTP(state.phoneNumber);
          }
        },
        builder: (context, state) {
          if (state is LoadingLogin) {
            return buildLoginWidget(context, true, null, state.phoneNumber);
          } else if (state is ErrorLogin) {
            return buildLoginWidget(
                context, false, state.message, state.phoneNumber);
          } else {
            return buildLoginWidget(context, false, null, null);
          }
        },
      ),
    );
  }

  Widget buildLoginWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    String? phoneNumber,
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
            title: Text('strBack'.tr),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                backgroundTopCurveWidget(context, null),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      // Greeting
                      greetingsLoginWidget(context),
                      const SizedBox(height: 48),
                      // Login Controls
                      LoginControlsWidget(
                        enteredPhone: phoneNumber,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 240,),
                const Text(
                  '${AppConstants.strCopyright} ${AppConstants.strAppName}',
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

  void openPageOTP(String phoneNumber) {
    Get.to(() => OTPPage(
          isRegistration: false,
          phoneNumber: phoneNumber,
        ));
  }
}
