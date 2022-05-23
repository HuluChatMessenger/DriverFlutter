import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class MainPage extends StatelessWidget {
  Driver driver;
  Configuration configuration;
  LatLng locationLatLng = const LatLng(9.005401, 38.763611);
  bool trafficEnabled = false;
  bool isFirst = true;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  MainPage({Key? key, required this.driver, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<MainBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MainBloc>(),
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if (state is LoadedMain) {}
        },
        builder: (context, state) {
          if (state is LoadingMain) {
            locationLatLng = state.currentLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(context, false, null, state.currentLatLng, state.isTraffic);
          } else if (state is LoadedMain) {
            driver = state.driver;
            locationLatLng = state.currentLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(context, false, null, state.currentLatLng, state.isTraffic);
          } else if (state is ErrorMain) {
            locationLatLng = state.currentLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(
                context, false, state.message, state.currentLatLng, state.isTraffic);
          } else {
            return buildMainWidget(context, false, null, locationLatLng, trafficEnabled);
          }
        },
      ),
    );
  }

  Widget buildMainWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    LatLng currentLocation,
    bool isTraffic,
  ) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          drawer: AppDrawer(
            driver: driver,
            configuration: configuration,
            scaffoldKey: _key,
          ),
          body: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: MapControlsWidget(
                    currentLatLng: currentLocation,
                    isTraffic: isTraffic,
                  )),
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 52,
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 16),
                      MaterialButton(
                        onPressed: () => _key.currentState!.openDrawer(),
                        child: const Icon(
                          Icons.menu_open_rounded,
                          color: Colors.green,
                        ),
                        color: Colors.white,
                        minWidth: 48,
                        height: 54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(54.0),
                        ),
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () async {
                          bool isPhoneCallAllowed =
                              await Permission.phone.request().isGranted;

                          if (isPhoneCallAllowed) {
                            contactCallCenter();
                          } else {
                            Permission.phone.request();
                          }
                        },
                        child: const Icon(
                          Icons.phone,
                          color: Colors.red,
                        ),
                        color: Colors.white,
                        minWidth: 48,
                        height: 54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(54.0),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  Spacer(),
                  MainCardControlsWidget(
                    driver: driver,
                    locationLatLng: currentLocation,
                    isTraffic: isTraffic,
                  ),
                  mainLoading(currentLocation, isTraffic),
                ],
              ),
            ],
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
  }

  Widget mainLoading(LatLng latLng, bool isTraffic) {
    checkPermission();
    bool isFirstTime = isFirst;
    isFirst = false;
    return MainControlsWidget(
      isFirst: isFirstTime,
      locationLatLng: latLng,
      isTraffic: isTraffic,
    );
  }

  Future<void> checkPermission() async {
    print('LogHulu permission');
    await Permission.locationAlways.request();
    if (await Permission.locationAlways.request().isGranted) {
      print('LogHulu permission granted');
      // Either the permission was already granted before or the user just granted it.
    } else {
      print('LogHulu permission granted');
    }
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

  contactCallCenter() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.DIAL',
        data: "tel:${AppConstants.phoneNumberCallCenter}",
      );
      await intent.launch();
    }
    ;
  }
}
