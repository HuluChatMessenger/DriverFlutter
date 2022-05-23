import 'package:equatable/equatable.dart';

class VehicleChannel extends Equatable {
  final int availableSeats;
  final String name;

  const VehicleChannel({
    required this.availableSeats,
    required this.name,
  });

  @override
  List<Object?> get props => [
        availableSeats,
        name,
      ];
}
