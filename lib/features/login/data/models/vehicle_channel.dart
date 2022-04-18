import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_channel.dart';

class VehicleChannelModel extends VehicleChannel {
  const VehicleChannelModel({required int availableSeats, required String name})
      : super(availableSeats: availableSeats, name: name);

  factory VehicleChannelModel.fromJson(Map<String, dynamic> json) {
    return VehicleChannelModel(
        availableSeats: json['available_sits'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      "available_sits": availableSeats,
      "name": name,
    };
  }
}
