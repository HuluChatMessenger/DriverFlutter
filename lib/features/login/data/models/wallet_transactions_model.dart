import 'package:hulutaxi_driver/features/login/data/models/wallet_transaction_Item_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transaction_item.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';

class WalletTransactionsModel extends WalletTransactions {
  WalletTransactionsModel({
    required count,
    required next,
    required results,
  }) : super(
          count: count,
          next: next,
          results: results,
        );

  factory WalletTransactionsModel.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> resultsFromJson = jsonData['results'];

    List<WalletTransactionItem> walletTransactionItemList = [];
    for (dynamic element in resultsFromJson) {
      WalletTransactionItem walletTransactionItem =
          WalletTransactionItemModel.fromJson(element);
      walletTransactionItemList.add(walletTransactionItem);
    }

    return WalletTransactionsModel(
      count: jsonData['count'],
      next: jsonData['next'],
      results: walletTransactionItemList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "next": next,
      "results": results,
    };
  }
}
