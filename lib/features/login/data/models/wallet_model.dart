import 'package:hulutaxi_driver/features/login/domain/entities/driver_wallet.dart';

class DriverWalletModel extends DriverWallet {
  const DriverWalletModel({required int id, required String balance})
      : super(id: id, balance: balance);

  factory DriverWalletModel.fromJson(json) {
    return DriverWalletModel(id: json['id'], balance: json['balance']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "balance": balance,
    };
  }
}
