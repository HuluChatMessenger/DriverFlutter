import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
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
  const SplashPage({Key? key}) : super(key: key);

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
                return Positioned(
                  bottom: 32,
                  right: 16,
                  left: 16,
                  child: Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
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
                openPageLanding(state.configuration.referralProgramEnabled);
              } else if (state is LoadedPicSplash) {
                openPagePic();
              } else if (state is LoadedVehicleSplash) {
                openPageVehicle(state.configuration);
              } else if (state is LoadedDocumentsSplash) {
                openPageDocuments(state.configuration, state.documents);
              } else if (state is LoadedWaitingSplash) {
                openPageWaiting();
              } else if (state is LoadedLoginSplash) {
                openPageMain();
              }
            },
          ),
        ],
      ),
    );
  }

  void openPageLanding(bool isReferral) {
    Get.offAll(() => LandingPage(isReferral: isReferral));
  }

  void openPagePic() {
    Get.offAll(() => AddPicPage());
  }

  void openPageVehicle(
      Configuration configuration) {
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
        ));
  }

  void openPageWaiting() {
    Get.offAll(() => const WaitingPage());
  }

  void openPageMain() {
    Get.offAll(() => const MainPage());
  }
}
