import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostDriver implements UseCase<Driver, Params> {
  final Repository repository;

  PostDriver(this.repository);

  @override
  Future<Either<Failure, Driver>> call(Params params) async {
    return await repository.postDriver(params.driver);
  }
}

class Params extends Equatable {
  final Driver driver;

  const Params({required this.driver});

  @override
  List<Object?> get props => [driver];
}
