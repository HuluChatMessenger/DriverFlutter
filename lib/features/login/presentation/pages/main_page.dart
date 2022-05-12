import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return buildMainWidget(context, false, null);
          } else if (state is LoadedMain) {
            driver = state.driver;
            return buildMainWidget(context, false, null);
          } else if (state is ErrorMain) {
            return buildMainWidget(context, false, state.message);
          } else {
            return buildMainWidget(context, false, null);
          }
        },
      ),
    );
  }

  Widget buildMainWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
  ) {
    return Stack(
      children: <Widget>[
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: MapControlsWidget(37.43296265331129, -122.08832357078792)),
        Scaffold(
          key: _key,
          drawer: AppDrawer(
            driver: driver,
            configuration: configuration,
          ),
          body: SingleChildScrollView(
            child: Column(
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
                      onPressed: () => {},
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
                Container(),
                const SizedBox(height: 4),
                mainLoading(),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
  }

  Widget mainLoading() {
    checkPermission();
    bool isFirstTime = isFirst;
    isFirst = false;
    return MainControlsWidget(
      isFirst: isFirstTime,
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
}
