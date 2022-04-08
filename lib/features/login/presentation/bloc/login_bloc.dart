import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';

import '../../domain/usecases/get_login_otp.dart';
import 'bloc.dart';

const String serverFailureMessage = "Server Failure";
const String cacheFailureMessage = "Cache Failure";
const String connectionFailureMessage =
    "Unable to connect to the internet. Please check your connection.";
const String unknownFailureMessage = 'Some error occurred. Please, try again!';
const String invalidInputFailureMessage =
    "Phone number starts with the digit 9 or 7!";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLoginOTP getLoginOTP;
  final InputConverter inputConverter;

  LoginBloc({required this.getLoginOTP, required this.inputConverter})
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
          emit(const Error(message: invalidInputFailureMessage));
        },
        (string) async {
          print('Request started');
          emit(Loading());

          final failureOrSuccess =
              await getLoginOTP(Params(phoneNumber: string));
          emit(failureOrSuccess.fold(
            (failure) {
              print('Response error');
              return Error(message: _mapFailureToMessage(failure));
            },
            (success) {
              print('Response received');
              return Loaded(login: success);
            },
          ));
        },
      );
    }
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case ConnectionFailure:
        return connectionFailureMessage;
      default:
        return unknownFailureMessage;
    }
  }
}
