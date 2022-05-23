import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:permission_handler/permission_handler.dart';

import '../widgets/widgets.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBody(context),
        buildBodyNtk(context),
      ],
    );
  }

  BlocProvider<SplashBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashBloc>()..add(GetSplash()),
      child: Stack(
        children: <Widget>[
          SplashWidget(),
          BlocConsumer<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state is ErrorSplash) {
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
                setNavBar();
                openPageLanding(state.configuration.referralProgramEnabled,
                    state.configuration);
              } else if (state is LoadedPicSplash) {
                setNavBar();
                openPagePic(state.driver.vehicle == null);
              } else if (state is LoadedVehicleSplash) {
                setNavBar();
                openPageVehicle(state.configuration);
              } else if (state is LoadedDocumentsSplash) {
                setNavBar();
                openPageDocuments(state.configuration, state.documents);
              } else if (state is LoadedWaitingSplash) {
                setNavBar();
                openPageWaiting(state.configuration);
              } else if (state is LoadedLoginSplash) {
                setNavBar();
                onLogin(state.driver, state.configuration);
              }
            },
          ),
        ],
      ),
    );
  }

  BlocProvider<NetworkBloc> buildBodyNtk(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NetworkBloc>()..add(ListenConnection()),
      child: Stack(
        children: <Widget>[
          BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              print('LogHulu Network : $state');
              if (state is NetworkFailure) {

              }

              return Container();
            },
          ),
        ],
      ),
    );
  }

  void setNavBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
    ));
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

  void onLogin(Driver driver, Configuration configuration) async {
    bool isLocationAllowed = await Permission.location.request().isGranted;
    bool isLocationAlwaysAllowed =
        await Permission.locationAlways.request().isGranted;
    bool isBatteryAllowed =
        await Permission.ignoreBatteryOptimizations.request().isGranted;

    if (isLocationAllowed) {
      if (isLocationAlwaysAllowed) {
        if (isBatteryAllowed) {
          openPageMain(driver, configuration);
        } else if (!isBatteryAllowed) {
          Permission.ignoreBatteryOptimizations.request();
        }
      } else if (!isBatteryAllowed) {
        Permission.locationAlways.request();
      }
    } else if (!isLocationAllowed) {
      Permission.location.request();
    }
  }

  void openPageMain(Driver driver, Configuration configuration) {
    Get.offAll(() => MainPage(driver: driver, configuration: configuration));
  }
}
