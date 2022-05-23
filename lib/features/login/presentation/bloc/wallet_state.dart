import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';

@immutable
abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

class EmptyWallet extends WalletState {
  @override
  List<Object?> get props => [];
}

class LoadingWallet extends WalletState {
  @override
  List<Object?> get props => [];
}

class LoadingWalletNext extends WalletState {
  final WalletTransactions walletTransactions;

  LoadingWalletNext({required this.walletTransactions});

  @override
  List<Object?> get props => [];
}

class LoadedWallet extends WalletState {
  final WalletTransactions walletTransactions;

  LoadedWallet({required this.walletTransactions});

  @override
  List<Object> get props => [];
}

class LoadedWalletNext extends WalletState {
  final WalletTransactions walletTransactions;

  LoadedWalletNext({required this.walletTransactions});

  @override
  List<Object> get props => [];
}

class ErrorWallet extends WalletState {
  final String message;

  ErrorWallet({required this.message});

  @override
  List<Object> get props => [];
}

class ErrorWalletNext extends WalletState {
  final String message;
  final WalletTransactions walletTransactions;

  ErrorWalletNext({required this.message, required this.walletTransactions});

  @override
  List<Object> get props => [];
}
