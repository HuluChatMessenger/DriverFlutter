import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_otp.dart';

import 'bloc.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final PostOtp postOtp;

  OtpBloc({required this.postOtp}) : super(OtpInitial()) {
    on<OtpEvent>(mapOTPState);
  }

  Future<void> mapOTPState(
    OtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    if (event is GetOTP) {
      print('Request started');
      emit(LoadingOtp());

      final failureOrSuccess = await postOtp(Params(otp: event.otp));
      emit(failureOrSuccess.fold(
        (failure) {
          print('Response error');
          return ErrorOtp(message: _mapFailureToMessage(failure));
        },
        (success) {
          print('Response received');
          return LoadedOtp(driver: success);
        },
      ));
    }
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
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
