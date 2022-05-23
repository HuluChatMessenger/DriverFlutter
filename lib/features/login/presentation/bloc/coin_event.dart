import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CoinEvent extends Equatable {
  const CoinEvent([List props = const <dynamic>[]]);
}

class GetCoinBalance extends CoinEvent {
  const GetCoinBalance() : super();

  @override
  List<Object> get props => [];
}

class GetCoinBuyAirtime extends CoinEvent {
  final Service service;
  final double currentBalance;
  final double amount;

  GetCoinBuyAirtime(this.currentBalance, this.amount, this.service)
      : super([currentBalance, amount, service]);

  @override
  List<Object> get props => [currentBalance, amount, service];
}
