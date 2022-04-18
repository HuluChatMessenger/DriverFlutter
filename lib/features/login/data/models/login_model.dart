import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel({required int id, required String phoneNumber})
      : super(id: id, phoneNumber: phoneNumber);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(id: json['id'], phoneNumber: json['phonenumber']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "phonenumber": phoneNumber,
    };
  }
}
