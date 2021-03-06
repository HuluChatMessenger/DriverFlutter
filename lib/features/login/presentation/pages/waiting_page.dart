import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/main_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class WaitingPage extends StatelessWidget {
  final Configuration configuration;

  const WaitingPage({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<WaitingBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WaitingBloc>(),
      child: Stack(
        children: <Widget>[
          backgroundWaitingWidget(context),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            child: Text('strThanks'.tr),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            child: Text('strWaitingTxt'.tr),
                          ),
                          WaitingWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<WaitingBloc, WaitingState>(
            builder: (context, state) {
              if (state is EmptyWaiting) {
                return WaitingWidget();
              } else if (state is LoadingWaiting) {
                return const LoadingWidget();
              } else {
                return Container();
              }
            },
            listener: (context, state) {
              print('LogHulu : $state');
              if (state is LoadedWaiting) {
                openPageMain(
                  state.driver,
                  state.configuration != null
                      ? state.configuration!
                      : configuration,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void openPageMain(Driver driver, Configuration configuration) {
    Get.to(() => MainPage(
          driver: driver,
          configuration: configuration,
        ));
  }
}
