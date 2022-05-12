import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_main.dart';

import 'bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final PostMain postMain;
  final GetDriver getDriver;


  MainBloc({required this.postMain, required this.getDriver}) : super(MainInitial()) {
    on<MainEvent>(mapMainState);
  }

  Future<void> mapMainState(
    MainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (event is GetMain) {
      print('LogHulu Main Request started');
      emit(LoadingMain());

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
            (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(message: _mapFailureToMessage(failure));
        },
            (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMain(driver: success);
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
