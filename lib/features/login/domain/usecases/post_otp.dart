import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostOtp implements UseCase<Driver, ParamsOtp> {
  final Repository repository;

  PostOtp(this.repository);

  @override
  Future<Either<Failure, Driver>> call(ParamsOtp params) async {
    return await repository.postOtp(params.otp);
  }
}

class ParamsOtp extends Equatable {
  final Otp otp;

  const ParamsOtp({required this.otp});

  @override
  List<Object?> get props => [otp];
}
