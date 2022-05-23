import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/airtime_success.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostAirtime implements UseCase<AirtimeSuccess, ParamsAirTime> {
  final Repository repository;

  PostAirtime(this.repository);

  @override
  Future<Either<Failure, AirtimeSuccess>> call(ParamsAirTime params) async {
    return await repository.postAirtime(params.service, params.amount);
  }
}

class ParamsAirTime extends Equatable {
  final Service service;
  final double amount;

  const ParamsAirTime({
    required this.service,
    required this.amount,
  });

  @override
  List<Object?> get props => [service, amount];
}
