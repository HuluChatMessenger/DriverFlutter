import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainState extends Equatable {
  const MainState();
}

class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class EmptyMain extends MainState {
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  const EmptyMain({required this.isTraffic, this.pickUpLatLng, this.destinationLatLng});

  @override
  List<Object?> get props => [];
}

class LoadingMain extends MainState {
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  const LoadingMain({required this.isTraffic, this.pickUpLatLng, this.destinationLatLng});

  @override
  List<Object?> get props => [];
}

class LoadedMain extends MainState {
  final Driver driver;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  const LoadedMain(
      {required this.driver,
      required this.isTraffic,
      this.pickUpLatLng,
      this.destinationLatLng});

  @override
  List<Object> get props => [];
}

class LoadedMainConnection extends MainState {
  final dynamic connectionStatus;

  const LoadedMainConnection({required this.connectionStatus});

  @override
  List<Object> get props => [];
}

class LoadedMainTraffic extends MainState {
  final Driver driver;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  const LoadedMainTraffic(
      {required this.driver,
      required this.isTraffic,
      this.pickUpLatLng,
      this.destinationLatLng});

  @override
  List<Object> get props => [];
}

class LoadedMainLocation extends MainState {
  final Driver driver;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;
  final bool isLocation;

  const LoadedMainLocation(
      {required this.driver,
      required this.isTraffic,
      required this.isLocation,
      this.pickUpLatLng,
      this.destinationLatLng});

  @override
  List<Object> get props => [];
}

class ErrorMain extends MainState {
  final String message;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  const ErrorMain(
      {required this.message,
      required this.isTraffic,
      this.pickUpLatLng,
      this.destinationLatLng});

  @override
  List<Object> get props => [];
}

class ErrorMainConnections extends MainState {
  final String message;

  const ErrorMainConnections({
    required this.message,
  });

  @override
  List<Object> get props => [];
}
