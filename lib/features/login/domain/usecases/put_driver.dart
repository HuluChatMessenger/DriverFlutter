import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PutDriver implements UseCase<Configuration, ParamsDriverUpdate> {
  final Repository repository;

  PutDriver(this.repository);

  @override
  Future<Either<Failure, Configuration>> call(ParamsDriverUpdate params) async {
    return await repository.putDriver(params.driver);
  }
}

class ParamsDriverUpdate extends Equatable {
  final Driver driver;

  const ParamsDriverUpdate({required this.driver});

  @override
  List<Object?> get props => [driver];
}
