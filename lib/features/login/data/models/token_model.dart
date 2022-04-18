import 'package:hulutaxi_driver/features/login/domain/entities/token_data.dart';

class TokenDataModel extends TokenData {
  const TokenDataModel({required String refresh, required String access})
      : super(refresh: refresh, access: access);

  factory TokenDataModel.fromJson(json) {
    return TokenDataModel(refresh: json['refresh'], access: json['access']);
  }

  Map<String, dynamic> toJson() {
    return {
      "refresh": refresh,
      "access": access,
    };
  }
}
