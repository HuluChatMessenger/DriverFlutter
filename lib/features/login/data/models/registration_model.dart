import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';

class RegistrationModel extends Registration {
  RegistrationModel(
      {required id,
        required firstName,
      required fatherName,
      required grandfatherName,
      required phoneNumber, referralCode})
      : super(
            id: id,
            firstName: firstName,
            fatherName: fatherName,
            grandfatherName: grandfatherName,
            phoneNumber: phoneNumber,
            referralCode: referralCode);

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      id: json['id'],
      firstName: json['first_name'],
      fatherName: json['middle_name'],
      grandfatherName: json['last_name'],
      phoneNumber: json['phonenumber'],
      referralCode: json['referral_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "middle_name": fatherName,
      "last_name": grandfatherName,
      "phonenumber": phoneNumber,
      "referral_code": referralCode,
    };
  }
}
