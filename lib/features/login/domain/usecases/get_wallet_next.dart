import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetWalletNext implements UseCase<WalletTransactions, ParamsWalletNext> {
  final Repository repository;

  GetWalletNext(this.repository);

  @override
  Future<Either<Failure, WalletTransactions>> call(
      ParamsWalletNext params) async {
    return await repository.getWallet(params.next);
  }
}

class ParamsWalletNext extends Equatable {
  final String next;

  const ParamsWalletNext({required this.next});

  @override
  List<Object?> get props => [next];
}
