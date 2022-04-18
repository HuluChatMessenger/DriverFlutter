import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';

import '../../../../core/error/failures.dart';
import 'bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetConfiguration getConfiguration;
  final GetDriver getDriver;

  SplashBloc({required this.getConfiguration, required this.getDriver})
      : super(SplashInitial()) {
    on<SplashEvent>(mapSplashState);
  }

  Future<void> mapSplashState(
    SplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    if (event is GetSplash) {
      final failureOrSuccessConfig = await getConfiguration(null);

      await failureOrSuccessConfig.fold(
        (failure) async {
          print('LogHulu: Config Response error');
          if (failure is LogoutFailure) {
            return LoadedLandingSplash(configuration: failure.configuration);
          } else {
            emit(ErrorSplash(message: _mapFailureToMessage(failure)));
          }
        },
        (success) async {
          print('LogHulu: Config Response received');

          final config = success;

          if (config.isLoggedIn) {
            final failureOrSuccessDriver = await getDriver(null);

            emit(failureOrSuccessDriver.fold(
              (failureDriver) {
                print('LogHulu: Driver Response error');
                return ErrorSplash(
                    message: _mapFailureToMessage(failureDriver));
              },
              (successDriver) {
                print('LogHulu: Driver Response received');
                if (!successDriver.isLoggedIn) {
                  return LoadedLandingSplash(configuration: config);
                } else if (!successDriver.isPicSubmitted) {
                  return LoadedPicSplash(driver: successDriver);
                } else if (successDriver.vehicle == null) {
                  return LoadedVehicleSplash(driver: successDriver);
                } else if (!successDriver.isDocumentSubmitted) {
                  return LoadedDocumentsSplash(driver: successDriver);
                } else if (!successDriver.isApproved) {
                  return LoadedWaitingSplash(driver: successDriver);
                } else {
                  return LoadedLoginSplash(driver: successDriver);
                }
              },
            ));
          } else {
            emit(LoadedLandingSplash(configuration: config));
          }
        },
      );
    }
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case LogoutFailure:
        return AppConstants.errMsgLogout;
      case ServerFailure:
        if (failure is ServerFailure &&
            failure.errMsg != null &&
            failure.errMsg!.isNotEmpty) {
          return failure.errMsg!;
        } else {
          return AppConstants.errMsgServer;
        }
      case ConnectionFailure:
        return AppConstants.errMsgConnection;
      default:
        return AppConstants.errMsgUnknown;
    }
  }
}
