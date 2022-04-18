import 'package:equatable/equatable.dart';

class VehicleColors extends Equatable {
  final String vehicleColorKey;
  final String vehicleColorLabel;
  final String vehicleColorCode;

  const VehicleColors({
    required this.vehicleColorKey,
    required this.vehicleColorLabel,
    required this.vehicleColorCode,
  });

  @override
  List<Object?> get props => [
        vehicleColorKey,
        vehicleColorLabel,
        vehicleColorCode,
      ];
}
