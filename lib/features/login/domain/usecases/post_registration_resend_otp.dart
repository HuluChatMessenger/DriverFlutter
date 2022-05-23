import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostResendOTPRegistration implements UseCase<Registration, ParamsResendOtpRegistration> {
  final Repository repository;

  PostResendOTPRegistration(this.repository);

  @override
  Future<Either<Failure, Registration>> call(ParamsResendOtpRegistration params) async {
    return await repository.postRegistrationOtp(params.registration);
  }
}

class ParamsResendOtpRegistration extends Equatable {
  final Registration registration;

  const ParamsResendOtpRegistration({required this.registration});

  @override
  List<Object?> get props => [registration];
}
