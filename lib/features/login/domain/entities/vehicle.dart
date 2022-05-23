import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/errors.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_channel.dart';

class Vehicle extends Equatable {
  final String color;
  final String model;
  final String plateNo;
  final int makeYear;
  VehicleChannel? channel;

  Vehicle({
    required this.color,
    required this.model,
    required this.plateNo,
    required this.makeYear,
    this.channel,
  });

  @override
  List<Object?> get props => [
        color,
        model,
        plateNo,
        makeYear,
        channel,
      ];
}
