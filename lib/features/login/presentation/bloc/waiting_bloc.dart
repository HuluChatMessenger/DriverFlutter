import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';

import 'bloc.dart';

class WaitingBloc extends Bloc<WaitingEvent, WaitingState> {
  final GetDriver getDriver;

  WaitingBloc({required this.getDriver}) : super(WaitingInitial()) {
    on<WaitingEvent>(mapWaitingState);
  }

  Future<void> mapWaitingState(
    WaitingEvent event,
    Emitter<WaitingState> emit,
  ) async {
    if (event is GetWaiting) {
      emit(LoadingWaiting());
      final failureOrSuccessDriver = await getDriver(null);

      emit(failureOrSuccessDriver.fold(
        (failureDriver) {
          print('LogHulu Waiting: Driver Response error');
          return ErrorWaiting(message: _mapFailureToMessage(failureDriver));
        },
        (success) {
          print('LogHulu Waiting: Driver Response received');
          if (success.isApproved) {
            return LoadedWaiting(driver: success);
          } else {
            return EmptyWaiting();
          }
        },
      ));
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
