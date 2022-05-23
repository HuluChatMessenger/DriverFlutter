import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transaction_item.dart';

class WalletTransactionItemModel extends WalletTransactionItem {
  WalletTransactionItemModel({
    required id,
    required transType,
    required reasonText,
    required status,
    required amount,
    required createdAt,
  }) : super(
          id: id,
          transType: transType,
          reasonText: reasonText,
          status: status,
          amount: amount,
          createdAt: createdAt,
        );

  factory WalletTransactionItemModel.fromJson(Map<String, dynamic> jsonData) {
    return WalletTransactionItemModel(
      id: jsonData['id'],
      transType: jsonData['trans_type'],
      reasonText: jsonData['reason_text'],
      status: jsonData['status'],
      amount: jsonData['amount'],
      createdAt: jsonData['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "trans_type": transType,
      "reason_text": reasonText,
      "status": status,
      "amount": amount,
      "created_at": createdAt,
    };
  }
}
