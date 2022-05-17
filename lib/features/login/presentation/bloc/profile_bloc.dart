import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_earning_six.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_logout.dart';

import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetDriver getDriver;
  final GetEarningSix getEarningSix;
  final GetLogout getLogout;

  ProfileBloc(
      {required this.getDriver,
      required this.getEarningSix,
      required this.getLogout})
      : super(ProfileInitial()) {
    on<ProfileEvent>(mapProfileState);
  }

  Future<void> mapProfileState(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (event is GetProfile) {
      print('LogHulu Profile Request started');
      emit(LoadingProfile());

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Profile Response error: $failure  ===|||=== result.');
          return ErrorProfile(message: _mapFailureToMessage(failure));
        },
        (success) {
          print(
              'LogHulu Profile Response success: $success  ===|||=== result.');
          return LoadedProfile(driver: success);
        },
      ));
    } else if (event is GetProfileEarning) {
      print('LogHulu Profile Request started');
      emit(LoadingProfileEarning());

      final failureOrSuccess = await getEarningSix(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Earning Response error: $failure  ===|||=== result.');
          return ErrorProfile(message: _mapFailureToMessage(failure));
        },
        (success) {
          print(
              'LogHulu Earning Response success: $success  ===|||=== result.');
          return LoadedProfileEarning(earning: success);
        },
      ));
    } else if (event is GetProfileLogout) {
      print('LogHulu Profile Logout Request started');
      emit(LoadingProfileEarning());

      final failureOrSuccess = await getLogout(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Logout Response error: $failure  ===|||=== result.');
          return ErrorProfile(message: _mapFailureToMessage(failure));
        },
        (success) {
          print('LogHulu Logout Response success: $success  ===|||=== result.');
          return LogoutProfile(configuration: success);
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
          return "errMsgServer".tr;
        }
      case ConnectionFailure:
        return "errMsgConnection".tr;
      default:
        return "errMsgUnknown".tr;
    }
  }
}
