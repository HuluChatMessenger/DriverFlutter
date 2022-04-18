import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                            child: Text(state.message),
                          ),
                        ],
                      ),
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
              } else if (state is LoadingSplash) {
              } else if (state is LoadedLandingSplash) {
                // openPagePic();
                openPageLanding(state.configuration.referralProgramEnabled);
              } else if (state is LoadedPicSplash) {
                openPagePic();
              } else if (state is LoadedVehicleSplash) {
                openPageVehicle();
              } else if (state is LoadedDocumentsSplash) {
                openPageDocuments();
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
    Get.to(() => LandingPage(isReferral: isReferral));
  }

  void openPagePic() {
    Get.to(() => AddPicPage());
  }

  void openPageVehicle() {
    Get.to(() => VehiclePage());
  }

  void openPageDocuments() {
    Get.to(() => DocumentsPage());
  }

  void openPageWaiting() {
    Get.to(() => WaitingPage());
  }

  void openPageMain() {
    Get.to(() => MainPage());
  }
}
