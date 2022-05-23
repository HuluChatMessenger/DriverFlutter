import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transaction_item.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WalletEvent extends Equatable {
  const WalletEvent([List props = const <dynamic>[]]);
}

class GetWalletFirst extends WalletEvent {

  GetWalletFirst() : super();

  @override
  List<Object> get props => [];
}

class GetWallet extends WalletEvent {
  final String nextUrl;
  final WalletTransactions walletTransactions;

  GetWallet(this.nextUrl, this.walletTransactions) : super([nextUrl, walletTransactions]);

  @override
  List<Object> get props => [nextUrl, walletTransactions];
}
