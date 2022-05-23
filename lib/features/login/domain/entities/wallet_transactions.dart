import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transaction_item.dart';

class WalletTransactions extends Equatable {
  final int count;
  final String next;
  final List<WalletTransactionItem> results;

  WalletTransactions({
    required this.count,
    required this.next,
    required this.results,
  });

  @override
  List<Object?> get props => [
        count,
        next,
        results,
      ];
}
