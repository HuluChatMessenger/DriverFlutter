import 'package:hulutaxi_driver/core/util/data_converter.dart';
import 'package:hulutaxi_driver/features/login/data/models/vehicle_colors_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_colors.dart';

class ConfigurationModel extends Configuration {
  ConfigurationModel({
    isLoggedIn,
    required referralProgramEnabled,
    required supportedVersion,
    required currentVersion,
    required documentTypes,
    required feedbackTypes,
    required feedbackUrgencyLevels,
    vehicleModels,
    vehicleColors,
  }) : super(
          referralProgramEnabled: referralProgramEnabled,
          supportedVersion: supportedVersion,
          currentVersion: currentVersion,
          documentTypes: documentTypes,
          feedbackTypes: feedbackTypes,
          feedbackUrgencyLevels: feedbackUrgencyLevels,
          vehicleModels: vehicleModels,
          vehicleColors: vehicleColors,
          isLoggedIn: isLoggedIn,
        );

  factory ConfigurationModel.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> vehicleColorsFromJson = jsonData['vehicle_colors'];

    List<VehicleColors> vehicleColorsList = [];
    for (dynamic element in vehicleColorsFromJson) {
      VehicleColors vehicleColor = VehicleColorsModel.fromJson(element);
      vehicleColorsList.add(vehicleColor);
    }

    return ConfigurationModel(
      referralProgramEnabled: jsonData['referral_program_enabled'],
      supportedVersion: jsonData['supported_version'],
      currentVersion: jsonData['current_version'],
      documentTypes:
          DataConverter.jsonToListOfListString(jsonData, 'document_types'),
      feedbackTypes:
          DataConverter.jsonToListOfListString(jsonData, 'feedback_types'),
      feedbackUrgencyLevels: DataConverter.jsonToListOfListString(
          jsonData, 'feedback_urgency_levels'),
      vehicleModels:
          DataConverter.jsonToListOfListString(jsonData, 'vehicle_models'),
      vehicleColors: vehicleColorsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isLoggedIn": isLoggedIn,
      "referral_program_enabled": referralProgramEnabled,
      "supported_version": supportedVersion,
      "current_version": currentVersion,
      "document_types": documentTypes,
      "feedback_types": feedbackTypes,
      "feedback_urgency_levels": feedbackUrgencyLevels,
      "vehicle_models": vehicleModels,
      "vehicle_colors": vehicleColors,
    };
  }
}
