import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';

class OtpModel extends Otp {
  const OtpModel(
      {required String otp,
      required String phoneNumber,
      required bool isRegistration})
      : super(
            otp: otp, phoneNumber: phoneNumber, isRegistration: isRegistration);

  factory OtpModel.fromJsonLogin(Map<String, dynamic> json) {
    return OtpModel(
        otp: json['otp'],
        phoneNumber: json['phonenumber'],
        isRegistration: false);
  }

  factory OtpModel.fromJsonRegistration(Map<String, dynamic> json) {
    return OtpModel(
        otp: json['otp'], phoneNumber: json['user'], isRegistration: true);
  }

  Map<String, dynamic> toJson() {
    if (isRegistration) {
      return {
        "otp": otp,
        "user": phoneNumber,
      };
    } else {
      return {
        "otp": otp,
        "phonenumber": phoneNumber,
      };
    }
  }
}
