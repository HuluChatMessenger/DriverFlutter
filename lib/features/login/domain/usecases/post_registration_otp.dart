import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostRegistrationOTP implements UseCase<Registration, Params> {
  final Repository repository;

  PostRegistrationOTP(this.repository);

  @override
  Future<Either<Failure, Registration>> call(Params params) async {
    return await repository.postRegistrationOtp(params.registration);
  }
}

class Params extends Equatable {
  final Registration registration;

  const Params({required this.registration});

  @override
  List<Object?> get props => [registration];
}
