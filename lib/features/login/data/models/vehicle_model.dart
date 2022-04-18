import 'package:hulutaxi_driver/features/login/data/models/vehicle_channel.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_channel.dart';

class VehicleModel extends Vehicle {
  const VehicleModel(
      {required String color,
      required String model,
      required String plateNo,
      required int makeYear,
      required VehicleChannel channel})
      : super(
          color: color,
          model: model,
          plateNo: plateNo,
          makeYear: makeYear,
          channel: channel,
        );

  factory VehicleModel.fromJson(json) {
    VehicleChannel vehicleChannel =
        VehicleChannelModel.fromJson(json['channel']);

    return VehicleModel(
      color: json['color'],
      model: json['model'],
      plateNo: json['plate_no'],
      makeYear: json['make_year'],
      channel: vehicleChannel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "color": color,
      "model": model,
      "plate_no": plateNo,
      "make_year": makeYear,
      "channel": channel,
    };
  }
}
