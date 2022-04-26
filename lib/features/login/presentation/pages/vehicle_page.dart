import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/document_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class VehiclePage extends StatelessWidget {
  final Configuration configuration;
  List<DriverDocuments>? documents;

  VehiclePage({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<VehicleBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VehicleBloc>(),
      child: Stack(
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
              title: const Text(AppConstants.strBack),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Top Background
                  backgroundTopCurveWidget(context),
                  // Content
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        VehicleControlsWidget(
                          configuration: configuration,
                        ),
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<VehicleBloc, VehicleState>(
            listener: (context, state) {
              if (state is LoadedVehicle) {
                List<DriverDocuments> documents = [];
                if (state.driver.driverDocuments != null) {
                  documents = state.driver.driverDocuments!;
                }
                openPageDocuments(documents);
              }
            },
            builder: (context, state) {
              if (state is LoadingVehicle) {
                return const LoadingWidget();
              } else if (state is ErrorVehicle) {
                return DialogWidget(
                  message: state.message,
                  isDismiss: true,
                  typeDialog: AppConstants.dialogTypeErr,
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

  void openPageDocuments(List<DriverDocuments> documents) {
    Get.offAll(() => DocumentPage(
          documentTypes: configuration.documentTypes,
          documents: documents,
          isSplash: true,
        ));
  }

  void openPageSplash() {
    Get.offAll(() => const SplashPage());
  }
}
