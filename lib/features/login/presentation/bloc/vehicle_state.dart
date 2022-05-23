import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_colors.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_models.dart';

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
  VehicleModels? selectedModel;
  VehicleColors? selectedColor;
  String? enteredPlate;
  String? enteredMakeYear;

  LoadingVehicle({
    this.selectedModel,
    this.selectedColor,
    this.enteredPlate,
    this.enteredMakeYear,
  });

  @override
  List<Object?> get props => [];
}

class LoadedVehicle extends VehicleState {
  final Driver driver;
  VehicleModels? selectedModel;
  VehicleColors? selectedColor;
  String? enteredPlate;
  String? enteredMakeYear;

  LoadedVehicle({
    required this.driver,
    this.selectedModel,
    this.selectedColor,
    this.enteredPlate,
    this.enteredMakeYear,
  });

  @override
  List<Object> get props => [];
}

class ErrorVehicle extends VehicleState {
  final String message;
  VehicleModels? selectedModel;
  VehicleColors? selectedColor;
  String? enteredPlate;
  String? enteredMakeYear;

  ErrorVehicle({
    required this.message,
    this.selectedModel,
    this.selectedColor,
    this.enteredPlate,
    this.enteredMakeYear,
  });

  @override
  List<Object> get props => [];
}
