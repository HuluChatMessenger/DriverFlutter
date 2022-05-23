import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostVehicle implements UseCase<Driver, Params> {
  final Repository repository;

  PostVehicle(this.repository);

  @override
  Future<Either<Failure, Driver>> call(Params params) async {
    return await repository.postVehicle(params.vehicle);
  }
}

class Params extends Equatable {
  final Vehicle vehicle;

  const Params({required this.vehicle});

  @override
  List<Object?> get props => [vehicle];
}
