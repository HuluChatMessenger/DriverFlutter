import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetEarnings implements UseCase<Earnings, ParamsEarnings> {
  final Repository repository;

  GetEarnings(this.repository);

  @override
  Future<Either<Failure, Earnings>> call(ParamsEarnings params) async {
    return await repository.getEarnings(params.type);
  }
}

class ParamsEarnings extends Equatable {
  final int type;

  const ParamsEarnings({required this.type});

  @override
  List<Object?> get props => [type];
}
