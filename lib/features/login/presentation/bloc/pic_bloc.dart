import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/data/models/driver_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/profile_pic.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_pic.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/put_driver.dart';

import 'bloc.dart';

class PicBloc extends Bloc<PicEvent, PicState> {
  final PostPic postPic;
  final PutDriver putDriver;
  final GetDriver getDriver;

  PicBloc(
      {required this.postPic, required this.putDriver, required this.getDriver})
      : super(PicInitial()) {
    on<PicEvent>(mapPicState);
  }

  Future<void> mapPicState(
    PicEvent event,
    Emitter<PicState> emit,
  ) async {
    if (event is GetPic) {
      print('LogHulu Pic: $event');

      emit(LoadingPic(selcetedPic: event.pic));
      ProfilePic? profilePic;
      final failureOrSuccessPic = await postPic(ParamsPic(pic: event.pic));

      await failureOrSuccessPic.fold(
        (failureDriver) async {
          print('LogHulu PicFailure: Driver Response error');
          return emit(ErrorPic(
              message: _mapFailureToMessage(failureDriver),
              selcetedPic: event.pic));
        },
        (success) async {
          print('LogHulu PicSuccess: Driver Response received');
          profilePic = success.profilePic;

          final failureOrSuccessDriver = await getDriver(null);

          await failureOrSuccessDriver.fold(
            (failureDriver) async {
              print('LogHulu Pic: Driver Response error $failureDriver');
              return emit(ErrorPic(
                  message: _mapFailureToMessage(failureDriver),
                  selcetedPic: event.pic));
            },
            (successDriver) async {
              print('LogHulu Pic: Driver Response received');

              DriverModel driverModel = DriverModel(
                id: successDriver.id,
                isApproved: successDriver.isApproved,
                isContactConfirmed: successDriver.isContactConfirmed,
                isDocumentSubmitted: successDriver.isDocumentSubmitted = false,
                isPicSubmitted: successDriver.isPicSubmitted = false,
                isLoggedIn: successDriver.isLoggedIn,
                isActive: successDriver.isActive,
                profilePic: profilePic,
                fName: successDriver.fName,
                mName: successDriver.mName,
                lName: successDriver.lName,
                email: successDriver.email,
                phoneNumber: successDriver.phoneNumber,
                state: successDriver.state,
                avgRating: successDriver.avgRating,
                userIdn: successDriver.userIdn,
                tokenData: successDriver.tokenData,
                vehicle: successDriver.vehicle,
                driverWallet: successDriver.driverWallet,
                driverDocuments: successDriver.driverDocuments,
              );

              final failureOrSuccessDriverUpdate =
                  await putDriver(ParamsDriverUpdate(driver: driverModel));

              emit(failureOrSuccessDriverUpdate.fold(
                (failureDriverUpdate) {
                  print(
                      'LogHulu PicUpdateDriver: Driver Response error $failureDriverUpdate');
                  return ErrorPic(
                      message: _mapFailureToMessage(failureDriverUpdate),
                      selcetedPic: event.pic);
                },
                (successDriverUpdate) {
                  print('LogHulu PicUpdateDriver: Driver Response received');
                  return LoadedPic(
                      configuration: successDriverUpdate,
                      selcetedPic: event.pic);
                },
              ));
            },
          );
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
