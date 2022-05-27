import 'package:android_intent_plus/android_intent.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
  LatLng? pickUpLatLng;
  LatLng? destinationLatLng;
  bool trafficEnabled = false;
  bool isFirst = true;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  MainPage({Key? key, required this.driver, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
    ));
    return buildBody(context);
  }

  BlocProvider<MainBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MainBloc>()..add(GetMain(null, null)),
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if (state is LoadedMain) {
          } else if (state is LoadedMainConnection) {
            print('LogHulu Main Connection: state received');
            if (state.connectionStatus != null) {
              try {
                Stream<DataConnectionStatus> value = state.connectionStatus!;
                value.listen((connectionState) {
                  print('LogHulu Main Connection: $connectionState');
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      if (DataConnectionStatus.connected == connectionState) {
                        Navigator.of(context).pop(true);
                      }
                      return AlertDialog(
                        content: Text(
                          'errMsgConnection'.tr,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('strCancel'.tr),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              } catch (e) {
                print('LogHulu Main Connection: $e');
              }
            }
          }
        },
        builder: (context, state) {
          if (state is LoadingMain) {
            pickUpLatLng = state.pickUpLatLng;
            destinationLatLng = state.destinationLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(context, false, null, state.isTraffic, false,
                state.pickUpLatLng, state.destinationLatLng);
          } else if (state is LoadedMain) {
            driver = state.driver;
            pickUpLatLng = state.pickUpLatLng;
            destinationLatLng = state.destinationLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(context, false, null, state.isTraffic, false,
                state.pickUpLatLng, state.destinationLatLng);
          } else if (state is LoadedMainTraffic) {
            driver = state.driver;
            pickUpLatLng = state.pickUpLatLng;
            destinationLatLng = state.destinationLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(context, false, null, state.isTraffic, false,
                state.pickUpLatLng, state.destinationLatLng);
          } else if (state is LoadedMainLocation) {
            driver = state.driver;
            pickUpLatLng = state.pickUpLatLng;
            destinationLatLng = state.destinationLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(context, false, null, state.isTraffic,
                state.isLocation, state.pickUpLatLng, state.destinationLatLng);
          } else if (state is ErrorMain) {
            pickUpLatLng = state.pickUpLatLng;
            destinationLatLng = state.destinationLatLng;
            trafficEnabled = state.isTraffic;
            return buildMainWidget(
                context,
                false,
                state.message,
                state.isTraffic,
                false,
                state.pickUpLatLng,
                state.destinationLatLng);
          } else {
            return buildMainWidget(context, false, null, trafficEnabled, false,
                pickUpLatLng, destinationLatLng);
          }
        },
      ),
    );
  }

  Widget buildMainWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    bool isTraffic,
    bool isLocation,
    LatLng? pickUpPosition,
    LatLng? destinationPosition,
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
                    isTraffic: isTraffic,
                    isLocation: isLocation,
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
                    isTraffic: isTraffic,
                    pickUpLatLng: pickUpLatLng,
                    destinationLatLng: destinationLatLng,
                  ),
                  // mainLoading(currentLocation, isTraffic),
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

  Future<void> checkPermission() async {
    print('LogHulu permission');
    bool isLocationAllowed = await Permission.location.request().isGranted;
    bool isLocationAlwaysAllowed =
        await Permission.locationAlways.request().isGranted;
    bool isBatteryAllowed =
        await Permission.ignoreBatteryOptimizations.request().isGranted;

    if (isLocationAllowed) {
      if (isLocationAlwaysAllowed) {
        if (isBatteryAllowed) {
          print('LogHulu permission : All granted');
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
