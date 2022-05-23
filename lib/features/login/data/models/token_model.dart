import 'package:hulutaxi_driver/features/login/domain/entities/token_data.dart';

class TokenDataModel extends TokenData {
  const TokenDataModel({required access})
      : super(access: access);

  factory TokenDataModel.fromJson(json) {
    return TokenDataModel(access: json['access']);
  }

  Map<String, dynamic> toJson() {
    return {
      "access": access,
    };
  }
}
