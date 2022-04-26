import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';

@immutable
abstract class VehicleState extends Equatable {
  const VehicleState();
}

class VehicleInitial extends VehicleState {
  @override
  List<Object> get props => [];
}

class EmptyVehicle extends VehicleState {
  @override
  List<Object?> get props => [];
}

class LoadingVehicle extends VehicleState {
  @override
  List<Object?> get props => [];
}

class LoadedVehicle extends VehicleState {
  final Driver driver;

  const LoadedVehicle({required this.driver});

  @override
  List<Object> get props => [];
}

class ErrorVehicle extends VehicleState {
  final String message;

  const ErrorVehicle({required this.message});

  @override
  List<Object> get props => [];
}
