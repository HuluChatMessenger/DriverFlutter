import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetLoginOTP implements UseCase<Login, Params> {
  final Repository repository;

  GetLoginOTP(this.repository);

  @override
  Future<Either<Failure, Login>> call(Params params) async {
    return await repository.getLoginOtp(params.phoneNumber);
  }
}

class Params extends Equatable {
  final String phoneNumber;

  const Params({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
