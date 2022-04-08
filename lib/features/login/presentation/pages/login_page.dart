import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/otp_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
              onPressed: () {},
            );
          },
        ),
        title: const Text('Back'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Stack(
        children: <Widget>[
          Column(
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
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is Empty) {
                return Container();
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                openPageOTP(context);
                return const Center(
                  child: Text('Login Success!'),
                );
              } else if (state is Error) {
                return MessageDisplayWidget(
                  message: state.message,
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

  void openPageOTP(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const OTPPage()));
  }

  void openPageBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
