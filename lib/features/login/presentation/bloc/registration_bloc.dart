import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_registration_otp.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/registration_state.dart';

import 'bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final PostRegistrationOTP postRegistrationOTP;
  final InputConverter inputConverter;

  RegistrationBloc(
      {required this.postRegistrationOTP, required this.inputConverter})
      : super(RegistrationInitial()) {
    on<RegistrationEvent>(mapRegistrationOTPState);
  }

  Future<void> mapRegistrationOTPState(
    RegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    if (event is GetOTPForRegistration) {
      final inputEither =
          inputConverter.stringValidPhone(event.registration.phoneNumber);
      await inputEither.fold(
        (failure) async {
          emit(ErrorRegistration(
              message: AppConstants.errMsgPhone,
              registration: event.registration));
        },
        (string) async {
          print('LogHulu Request started');
          emit(LoadingRegistration(registration: event.registration));

          final failureOrSuccess = await postRegistrationOTP(
              Params(registration: event.registration));
          emit(failureOrSuccess.fold(
            (failure) {
              print('LogHulu Response error');
              return ErrorRegistration(
                  message: _mapFailureToMessage(failure),
                  registration: event.registration);
            },
            (success) {
              print('LogHulu Response received');
              return LoadedRegistration(registration: success);
            },
          ));
        },
      );
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
