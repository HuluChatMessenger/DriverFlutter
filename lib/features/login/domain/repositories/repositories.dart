import 'package:dartz/dartz.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';

abstract class Repository {
  Future<Either<Failure, Login>> postLoginOtp(String phoneNumber);

  Future<Either<Failure, Registration>> postRegistrationOtp(
      Registration registration);

  Future<Either<Failure, Driver>> postOtp(Otp otp);

  Future<Either<Failure, Driver>> postPic(String pic);

  Future<Either<Failure, Driver>> postDriver(Driver driver);

  Future<Either<Failure, Driver>> postVehicle(Vehicle vehicle);

  Future<Either<Failure, Driver>> postDocument(DriverDocuments document);

  Future<Either<Failure, Configuration>> getConfiguration();

  Future<Either<Failure, Configuration>> getConfigurationCache();

  Future<Either<Failure, Driver>> getDriver();
}
