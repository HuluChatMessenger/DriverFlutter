import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_colors.dart';

class Configuration extends Equatable {
  bool? isLoggedIn = false;
  final bool referralProgramEnabled;
  final double supportedVersion;
  final double currentVersion;
  final List<List<String>> documentTypes;
  final List<List<String>> feedbackTypes;
  final List<List<String>> feedbackUrgencyLevels;
  final List<List<String>> vehicleModels;
  final List<VehicleColors> vehicleColors;

  Configuration({
    this.isLoggedIn,
    required this.referralProgramEnabled,
    required this.supportedVersion,
    required this.currentVersion,
    required this.documentTypes,
    required this.feedbackTypes,
    required this.feedbackUrgencyLevels,
    required this.vehicleModels,
    required this.vehicleColors,
  });

  @override
  List<Object?> get props => [
        isLoggedIn,
        referralProgramEnabled,
        supportedVersion,
        currentVersion,
        documentTypes,
        feedbackTypes,
        feedbackUrgencyLevels,
        vehicleModels,
        vehicleColors,
      ];
}
