import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetEarningsInitial
    implements UseCase<Earnings, ParamsEarningsInitial> {
  final Repository repository;

  GetEarningsInitial(this.repository);

  @override
  Future<Either<Failure, Earnings>> call(
      ParamsEarningsInitial? params) async {
    return await repository.getEarnings(0);
  }
}

class ParamsEarningsInitial extends Equatable {
  const ParamsEarningsInitial();

  @override
  List<Object?> get props => [];
}
