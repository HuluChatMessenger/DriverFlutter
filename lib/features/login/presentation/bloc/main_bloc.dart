import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_connection.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_main.dart';

import 'bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final PostMain postMain;
  final GetDriver getDriver;
  final GetConnection getConnection;

  MainBloc(
      {required this.postMain,
      required this.getDriver,
      required this.getConnection})
      : super(MainInitial()) {
    on<MainEvent>(mapMainState);
  }

  Future<void> mapMainState(
    MainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (event is GetMain) {
      print('LogHulu Main Request started');
      emit(LoadingMain(
          isTraffic: false,
          pickUpLatLng: event.pickUpLatLng,
          destinationLatLng: event.destinationLatLng));

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(
              message: _mapFailureToMessage(failure),
              isTraffic: false,
              pickUpLatLng: event.pickUpLatLng,
              destinationLatLng: event.destinationLatLng);
        },
        (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMain(
              driver: success,
              isTraffic: false,
              pickUpLatLng: event.pickUpLatLng,
              destinationLatLng: event.destinationLatLng);
        },
      ));
    } else if (event is GetTraffic) {
      print('LogHulu Main Request started');
      emit(LoadingMain(
          isTraffic: false,
          pickUpLatLng: event.pickUpLatLng,
          destinationLatLng: event.destinationLatLng));

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(
              message: _mapFailureToMessage(failure),
              isTraffic: event.isTraffic,
              pickUpLatLng: event.pickUpLatLng,
              destinationLatLng: event.destinationLatLng);
        },
        (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMainTraffic(
              driver: success,
              isTraffic: event.isTraffic,
              pickUpLatLng: event.pickUpLatLng,
              destinationLatLng: event.destinationLatLng);
        },
      ));
    } else if (event is GetConnectionState) {
      print('LogHulu Main Connection: Request started');
      final failureOrSuccessConnection = await getConnection(null);
      await failureOrSuccessConnection.fold((failure) async {
        print('LogHulu Main Connection: Response error');
        emit(ErrorMainConnections(
          message: _mapFailureToMessage(failure),
        ));
      }, (success) async {
        emit(LoadedMainConnection(connectionStatus: success));
        // emit.forEach(success,
        //     onData: (connectionStatus) => LoadedReconnectSplash(
        //         connectionStatus: connectionStatus));
      });
    } else if (event is GetLocation) {
      print('LogHulu Main Request started');
      emit(LoadingMain(
          isTraffic: event.isTraffic,
          pickUpLatLng: event.pickUpLatLng,
          destinationLatLng: event.destinationLatLng));

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(
              message: _mapFailureToMessage(failure),
              isTraffic: event.isTraffic,
              pickUpLatLng: event.pickUpLatLng,
              destinationLatLng: event.destinationLatLng);
        },
        (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMainLocation(
              driver: success,
              isTraffic: event.isTraffic,
              isLocation: event.isLocation,
              pickUpLatLng: event.pickUpLatLng,
              destinationLatLng: event.destinationLatLng);
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
