import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_colors.dart';

class VehicleColorsModel extends VehicleColors {
  const VehicleColorsModel(
      {required vehicleColorKey,
      required vehicleColorLabel,
      required vehicleColorCode})
      : super(
            vehicleColorKey: vehicleColorKey,
            vehicleColorLabel: vehicleColorLabel,
            vehicleColorCode: vehicleColorCode);

  factory VehicleColorsModel.fromJson(dynamic json) {
    return VehicleColorsModel(
        vehicleColorKey: json['key'],
        vehicleColorLabel: json['label'],
        vehicleColorCode: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {
      "key": vehicleColorKey,
      "label": vehicleColorLabel,
      "code": vehicleColorCode,
    };
  }
}
