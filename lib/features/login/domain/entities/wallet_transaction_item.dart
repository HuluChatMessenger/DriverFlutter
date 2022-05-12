import 'package:equatable/equatable.dart';

class WalletTransactionItem extends Equatable {
  final int id;
  final int transType;
  final String reasonText;
  final String status;
  final String amount;
  final String createdAt;

  WalletTransactionItem({
    required this.id,
    required this.transType,
    required this.reasonText,
    required this.status,
    required this.amount,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        transType,
        reasonText,
        status,
        amount,
        createdAt,
      ];
}
