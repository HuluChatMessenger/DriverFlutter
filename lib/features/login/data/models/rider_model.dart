import 'package:hulutaxi_driver/features/login/domain/entities/rider.dart';

class RiderModel extends Rider {
  RiderModel({
    required id,
    required phoneNumber,
    required firstName,
    required lastName,
  }) : super(
          id: id,
    phoneNumber: phoneNumber,
    firstName: firstName,
    lastName: lastName,
        );

  factory RiderModel.fromJson(Map<String, dynamic> jsonData) {
    return RiderModel(
      id: jsonData['id'],
      phoneNumber: jsonData['phonenumber'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "phonenumber": phoneNumber,
      "first_name": firstName,
      "last_name": lastName,
    };
  }
}
