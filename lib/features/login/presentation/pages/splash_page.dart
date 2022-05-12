import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/document_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/landing_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/main_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/pic_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/vehicle_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/waiting_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../widgets/widgets.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<SplashBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashBloc>(),
      child: Stack(
        children: <Widget>[
          const SplashWidget(),
          BlocConsumer<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state is ErrorSplash) {
                const SplashWidget();
                return Positioned(
                  bottom: 32,
                  right: 16,
                  left: 16,
                  child: Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontStyle: FontStyle.italic,
                      ),
                      child: Text(state.message),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
            listener: (context, state) {
              print('LogHulu : $state');
              if (state is EmptySplash) {
              } else if (state is LoadedLandingSplash) {
                openPageLanding(state.configuration.referralProgramEnabled,
                    state.configuration);
              } else if (state is LoadedPicSplash) {
                openPagePic(state.driver.vehicle == null);
              } else if (state is LoadedVehicleSplash) {
                openPageVehicle(state.configuration);
              } else if (state is LoadedDocumentsSplash) {
                openPageDocuments(state.configuration, state.documents);
              } else if (state is LoadedWaitingSplash) {
                openPageWaiting(state.configuration);
              } else if (state is LoadedLoginSplash) {
                openPageMain(state.driver, state.configuration);
              }
            },
          ),
        ],
      ),
    );
  }

  void startReload() {
    const oneSec = Duration(seconds: 1);
    int start = 5;
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          startReload();
          const SplashWidget();
        } else {
          start--;
        }
      },
    );
  }

  void openPageLanding(bool isReferral, Configuration configuration) {
    Get.offAll(() => LandingPage(
          isReferral: isReferral,
          configuration: configuration,
        ));
  }

  void openPagePic(bool isNextVehicle) {
    Get.offAll(() => AddPicPage(
          isNextVehicle: isNextVehicle,
        ));
  }

  void openPageVehicle(Configuration configuration) {
    Get.offAll(() => VehiclePage(
          configuration: configuration,
        ));
  }

  void openPageDocuments(
      Configuration configuration, List<DriverDocuments> documents) {
    Get.offAll(() => DocumentPage(
          documentTypes: configuration.documentTypes,
          documents: documents,
          isSplash: true,
          configuration: configuration,
        ));
  }

  void openPageWaiting(Configuration configuration) {
    Get.offAll(() => WaitingPage(
          configuration: configuration,
        ));
  }

  void openPageMain(Driver driver, Configuration configuration) {
    Get.offAll(() => MainPage(driver: driver, configuration: configuration));
  }
}
