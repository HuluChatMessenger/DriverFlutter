import 'package:equatable/equatable.dart';
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
  final LatLng currentLatLng;
  final bool isTraffic;

  const EmptyMain({required this.currentLatLng, required this.isTraffic});

  @override
  List<Object?> get props => [];
}

class LoadingMain extends MainState {
  final LatLng currentLatLng;
  final bool isTraffic;

  const LoadingMain({required this.currentLatLng, required this.isTraffic});

  @override
  List<Object?> get props => [];
}

class LoadedMain extends MainState {
  final Driver driver;
  final LatLng currentLatLng;
  final bool isTraffic;

  const LoadedMain(
      {required this.driver,
      required this.currentLatLng,
      required this.isTraffic});

  @override
  List<Object> get props => [];
}

class ErrorMain extends MainState {
  final String message;
  final LatLng currentLatLng;
  final bool isTraffic;

  const ErrorMain(
      {required this.message,
      required this.currentLatLng,
      required this.isTraffic});

  @override
  List<Object> get props => [];
}
