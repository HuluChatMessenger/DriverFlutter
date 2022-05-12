import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetWalletInitial
    implements UseCase<WalletTransactions, ParamsWalletInitial> {
  final Repository repository;

  GetWalletInitial(this.repository);

  @override
  Future<Either<Failure, WalletTransactions>> call(
      ParamsWalletInitial? params) async {
    return await repository.getWallet(null);
  }
}

class ParamsWalletInitial extends Equatable {
  const ParamsWalletInitial();

  @override
  List<Object?> get props => [];
}
