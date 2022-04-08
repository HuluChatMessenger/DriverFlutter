import 'package:dartz/dartz.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';

abstract class Repository {
  Future<Either<Failure, Login>> getLoginOtp(String phoneNumber);
}
