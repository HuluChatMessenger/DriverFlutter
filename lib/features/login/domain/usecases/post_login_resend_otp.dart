import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostResendOTPLogin implements UseCase<Login, ParamsResendOtpLogin> {
  final Repository repository;

  PostResendOTPLogin(this.repository);

  @override
  Future<Either<Failure, Login>> call(ParamsResendOtpLogin params) async {
    return await repository.postLoginOtp(params.phoneNumber);
  }
}

class ParamsResendOtpLogin extends Equatable {
  final String phoneNumber;

  const ParamsResendOtpLogin({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
