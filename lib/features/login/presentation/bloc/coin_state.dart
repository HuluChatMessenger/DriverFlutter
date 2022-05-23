import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/airtime_success.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CoinState extends Equatable {
  const CoinState();
}

class CoinInitial extends CoinState {
  @override
  List<Object> get props => [];
}

class EmptyCoin extends CoinState {
  @override
  List<Object?> get props => [];
}

class LoadingCoinBalance extends CoinState {
  @override
  List<Object?> get props => [];
}

class LoadingCoinBuyAirtime extends CoinState {
  final Service? service;
  final double currentBalance;

  LoadingCoinBuyAirtime({required this.currentBalance, required this.service});

  @override
  List<Object?> get props => [];
}

class LoadedCoinBalance extends CoinState {
  final Service? service;
  final double currentBalance;

  LoadedCoinBalance({required this.currentBalance, required this.service});

  @override
  List<Object> get props => [];
}

class LoadedCoinBuyAirtime extends CoinState {
  final Service? service;
  final AirtimeSuccess airtimeSuccess;

  LoadedCoinBuyAirtime({
    required this.airtimeSuccess,
    required this.service,
  });

  @override
  List<Object> get props => [];
}

class ErrorCoinBalance extends CoinState {
  final String message;

  ErrorCoinBalance({required this.message});

  @override
  List<Object> get props => [];
}

class ErrorCoinBuyAirtime extends CoinState {
  final String message;
  final double currentBalance;
  final Service? service;

  ErrorCoinBuyAirtime({
    required this.message,
    required this.currentBalance,
    required this.service,
  });

  @override
  List<Object> get props => [];
}
