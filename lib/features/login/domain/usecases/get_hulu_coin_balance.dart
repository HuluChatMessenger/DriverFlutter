import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetHuluCoinBalance
    implements UseCase<double, ParamsCoinBalance> {
  final Repository repository;

  GetHuluCoinBalance(this.repository);

  @override
  Future<Either<Failure, double>> call(
      ParamsCoinBalance? params) async {
    return await repository.getHuluCoinBalance();
  }
}

class ParamsCoinBalance extends Equatable {
  const ParamsCoinBalance();

  @override
  List<Object?> get props => [];
}
