import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_colors.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_models.dart';
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
      child: BlocConsumer<VehicleBloc, VehicleState>(
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
            return buildVehicleWidget(
              context,
              true,
              null,
              state.enteredPlate,
              state.enteredPlate,
              state.selectedModel,
              state.selectedColor,
            );
          } else if (state is ErrorVehicle) {
            return buildVehicleWidget(
              context,
              false,
              state.message,
              state.enteredPlate,
              state.enteredPlate,
              state.selectedModel,
              state.selectedColor,
            );
          } else {
            return buildVehicleWidget(
              context,
              false,
              null,
              null,
              null,
              null,
              null,
            );
          }
        },
      ),
    );
  }

  Widget buildVehicleWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    String? enteredPlate,
    String? enteredMakeYear,
    VehicleModels? vehicleModels,
    VehicleColors? vehicleColors,
  ) {
    return Stack(
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
                backgroundTopCurveWidget(context, null),
                // Content
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      VehicleControlsWidget(
                        configuration: configuration,
                        selectedModel: vehicleModels,
                        selectedColor: vehicleColors,
                        enteredPlate: enteredPlate,
                        enteredMakeYear: enteredMakeYear,
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
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

  void openPageDocuments(List<DriverDocuments> documents) {
    Get.offAll(() => DocumentPage(
          documentTypes: configuration.documentTypes,
          documents: documents,
          isSplash: true,
          configuration: configuration,
        ));
  }

  void openPageSplash() {
    Get.offAll(() => SplashPage());
  }
}
