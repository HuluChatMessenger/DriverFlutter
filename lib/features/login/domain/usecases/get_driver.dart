import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

import '../entities/driver.dart';

class GetDriver implements UseCase<Driver, Params> {
  final Repository repository;

  GetDriver(this.repository);

  @override
  Future<Either<Failure, Driver>> call(Params? params) async {
    return await repository.getDriver();
  }
}

class Params extends Equatable {
  const Params();

  @override
  List<Object?> get props => [];
}
