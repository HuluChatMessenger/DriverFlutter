import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VehicleEvent extends Equatable {
  const VehicleEvent([List props = const <dynamic>[]]);
}

class GetVehicle extends VehicleEvent {
  final Vehicle vehicle;

  GetVehicle(this.vehicle)
      : super([vehicle]);

  @override
  List<Object> get props => [vehicle];
}
