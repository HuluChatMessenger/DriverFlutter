import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';

import 'bloc.dart';

class WaitingBloc extends Bloc<WaitingEvent, WaitingState> {
  final GetDriver getDriver;
  final GetConfiguration getConfiguration;

  WaitingBloc({required this.getDriver, required this.getConfiguration})
      : super(WaitingInitial()) {
    on<WaitingEvent>(mapWaitingState);
  }

  Future<void> mapWaitingState(
    WaitingEvent event,
    Emitter<WaitingState> emit,
  ) async {
    if (event is GetWaiting) {
      emit(LoadingWaiting());
      final failureOrSuccessDriver = await getDriver(null);

      await failureOrSuccessDriver.fold(
        (failureDriver) async {
          print('LogHulu Waiting: Driver Response error');
          emit(ErrorWaiting(message: _mapFailureToMessage(failureDriver)));
        },
        (success) async {
          print('LogHulu Waiting: Driver Response received');

          if (success.isApproved) {
            Driver driver = success;
            final failureOrSuccessConfiguration = await getConfiguration(null);
            emit(
              failureOrSuccessConfiguration.fold(
                (failureConfig) {
                  print(
                      'LogHulu Waiting: Config Response error $failureConfig ||| == result');
                  return LoadedWaiting(driver: driver, configuration: null);
                },
                (successConfig) {
                  print('LogHulu Waiting: Driver Response received');

                  return LoadedWaiting(
                      driver: driver, configuration: successConfig);
                },
              ),
            );
          } else {
            emit(EmptyWaiting());
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
