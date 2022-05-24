import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_main.dart';

import 'bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final PostMain postMain;
  final GetDriver getDriver;

  MainBloc({required this.postMain, required this.getDriver})
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
          currentLatLng: getCurrentLocation(event.currentLatLng),
          isTraffic: false));

      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(
              message: _mapFailureToMessage(failure),
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: false);
        },
        (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMain(
              driver: success,
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: false);
        },
      ));
    } else if (event is GetTraffic) {
      print('LogHulu Main Request started');
      emit(LoadingMain(
          currentLatLng: getCurrentLocation(event.currentLatLng),
          isTraffic: false));

      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(
              message: _mapFailureToMessage(failure),
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: event.isTraffic);
        },
        (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMainTraffic(
              driver: success,
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: event.isTraffic);
        },
      ));
    } else if (event is GetLocation) {
      print('LogHulu Main Request started');
      emit(LoadingMain(
          currentLatLng: getCurrentLocation(event.currentLatLng),
          isTraffic: event.isTraffic));

      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(
              message: _mapFailureToMessage(failure),
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: event.isTraffic);
        },
        (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMainLocation(
              driver: success,
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: event.isTraffic,
              isLocation: event.isLocation);
        },
      ));
    } else if (event is GetLocationUpdate) {
      print('LogHulu Main Request started');
      emit(LoadingMain(
          currentLatLng: getCurrentLocation(event.currentLatLng),
          isTraffic: event.isTraffic));

      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      final failureOrSuccess = await getDriver(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Main Response error: $failure  ===|||=== result.');
          return ErrorMain(
              message: _mapFailureToMessage(failure),
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: event.isTraffic);
        },
        (success) {
          print('LogHulu Main Response success: $success  ===|||=== result.');
          return LoadedMain(
              driver: success,
              currentLatLng: getCurrentLocation(currentLatLng),
              isTraffic: event.isTraffic);
        },
      ));
    }
  }

  LatLng getCurrentLocation(LatLng? location) {
    location ??= const LatLng(9.005401, 38.763611);
    return location;
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
