import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_pic.dart';

import 'bloc.dart';

class PicBloc extends Bloc<PicEvent, PicState> {
  final PostPic postPic;

  PicBloc({required this.postPic}) : super(PicInitial()) {
    on<PicEvent>(mapPicState);
  }

  Future<void> mapPicState(
    PicEvent event,
    Emitter<PicState> emit,
  ) async {
    if (event is GetPic) {
      emit(LoadingPic());
      final failureOrSuccessDriver = await postPic(Params(pic: event.pic));

      emit(failureOrSuccessDriver.fold(
        (failureDriver) {
          print('LogHulu Waiting: Driver Response error');
          return ErrorPic(message: _mapFailureToMessage(failureDriver));
        },
        (success) {
          print('LogHulu Waiting: Driver Response received');
          if (success.isApproved) {
            return LoadedPic(driver: success);
          } else {
            return EmptyPic();
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
