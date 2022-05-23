import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetEarningSix implements UseCase<Earning, ParamsEarningSix> {
  final Repository repository;

  GetEarningSix(this.repository);

  @override
  Future<Either<Failure, Earning>> call(
      ParamsEarningSix? params) async {
    return await repository.getEarningsSixMonth();
  }
}

class ParamsEarningSix extends Equatable {
  const ParamsEarningSix();

  @override
  List<Object?> get props => [];
}
