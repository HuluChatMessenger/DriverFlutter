import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_colors.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VehicleEvent extends Equatable {
  const VehicleEvent([List props = const <dynamic>[]]);
}

class GetVehicle extends VehicleEvent {
  final Vehicle vehicle;
  final VehicleModels vehicleModels;
  final VehicleColors vehicleColors;

  GetVehicle(
    this.vehicle,
    this.vehicleModels,
    this.vehicleColors,
  ) : super([
          vehicle,
          vehicleModels,
          vehicleColors,
        ]);

  @override
  List<Object> get props => [
        vehicle,
        vehicleModels,
        vehicleColors,
      ];
}
