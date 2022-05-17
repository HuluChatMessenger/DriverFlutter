import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';

import '../../../../core/util/constants.dart';
import '../../domain/usecases/post_login_otp.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLoginOTP postLoginOTP;
  final InputConverter inputConverter;

  LoginBloc({required this.postLoginOTP, required this.inputConverter})
      : super(LoginInitial()) {
    on<LoginEvent>(mapLoginOTPState);
  }

  Future<void> mapLoginOTPState(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (event is GetOTPForLogin) {
      final inputEither = inputConverter.stringValidPhone(event.phoneNumber);
      await inputEither.fold(
        (failure) async {
          emit(ErrorLogin(
              message: 'errMsgPhone'.tr,
              phoneNumber: event.phoneNumber));
        },
        (string) async {
          print('LogHulu Request started');
          emit(LoadingLogin(phoneNumber: event.phoneNumber));

          final failureOrSuccess =
              await postLoginOTP(Params(phoneNumber: string));
          emit(failureOrSuccess.fold(
            (failure) {
              print('LogHulu Response error');
              return ErrorLogin(
                  message: _mapFailureToMessage(failure),
                  phoneNumber: event.phoneNumber);
            },
            (success) {
              print('LogHulu Response received');
              return LoadedLogin(phoneNumber: event.phoneNumber);
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
          return "errMsgServer".tr;
        }
      case ConnectionFailure:
        return "errMsgConnection".tr;
      default:
        return "errMsgUnknown".tr;
    }
  }
}
