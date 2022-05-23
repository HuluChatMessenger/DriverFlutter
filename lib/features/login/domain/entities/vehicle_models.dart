import 'package:equatable/equatable.dart';

class VehicleModels extends Equatable {
  final String vehicleModelKey;
  final String vehicleModelLabel;

  const VehicleModels({
    required this.vehicleModelKey,
    required this.vehicleModelLabel,
  });

  @override
  List<Object?> get props => [
        vehicleModelKey,
        vehicleModelLabel,
      ];
}
