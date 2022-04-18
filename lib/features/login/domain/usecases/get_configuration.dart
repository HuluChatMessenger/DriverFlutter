import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetConfiguration implements UseCase<Configuration, Params> {
  final Repository repository;

  GetConfiguration(this.repository);

  @override
  Future<Either<Failure, Configuration>> call(Params? params) async {
    return await repository.getConfiguration();
  }
}

class Params extends Equatable {
  const Params();

  @override
  List<Object?> get props => [];
}
