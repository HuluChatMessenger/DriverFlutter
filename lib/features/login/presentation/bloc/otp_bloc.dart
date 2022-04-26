import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_login_resend_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_registration_resend_otp.dart';

import 'bloc.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final PostOtp postOtp;
  final PostResendOTPLogin postLoginOTP;
  final PostResendOTPRegistration postRegistrationOTP;

  OtpBloc({required this.postOtp, required this.postLoginOTP, required this.postRegistrationOTP}) : super(OtpInitial()) {
    on<OtpEvent>(mapOTPState);
  }

  Future<void> mapOTPState(
    OtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    if (event is GetOTP) {
      print('LogHulu Request started');
      emit(LoadingOtp());

      final failureOrSuccess = await postOtp(Params(otp: event.otp));
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response error');
          return ErrorOtp(message: _mapFailureToMessage(failure));
        },
        (success) {
          print('LogHulu Response received');
          return LoadedOtp(driver: success);
        },
      ));
    } else if (event is ResendOTPLogin) {
      print('LogHulu Request started');
      emit(LoadingOtp());

      final failureOrSuccess =
      await postLoginOTP(ParamsResendOtpLogin(phoneNumber: event.phoneNumber));
      emit(failureOrSuccess.fold(
            (failure) {
          print('LogHulu Response error');
          return ErrorOtp(message: _mapFailureToMessage(failure));
        },
            (success) {
          print('LogHulu Response received');
          return LoadedOtpResendLogin(phoneNumber: event.phoneNumber);
        },
      ));
    } else if (event is ResendOTPRegistration) {
      print('LogHulu Request started');
      emit(LoadingOtp());

      final failureOrSuccess = await postRegistrationOTP(
          ParamsResendOtpRegistration(registration: event.registration));
      emit(failureOrSuccess.fold(
            (failure) {
          print('LogHulu Response error');
          return ErrorOtp(message: _mapFailureToMessage(failure));
        },
            (success) {
          print('LogHulu Response received');
          return LoadedOtpResendRegistration(registration: success);
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
