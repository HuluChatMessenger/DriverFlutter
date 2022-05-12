import 'package:hulutaxi_driver/features/login/domain/entities/hulu_coin.dart';

class HuluCoinModel extends HuluCoin {
  const HuluCoinModel({required balance}) : super(balance: balance);

  factory HuluCoinModel.fromJson(Map<String, dynamic> json) {
    return HuluCoinModel(balance: json['balance']);
  }

  Map<String, dynamic> toJson() {
    return {"balance": balance};
  }
}
