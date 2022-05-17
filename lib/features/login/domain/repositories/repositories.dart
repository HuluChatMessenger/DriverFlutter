import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_document_request.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/airtime_success.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/feedbacks.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:image_picker/image_picker.dart';

abstract class Repository {
  Future<Either<Failure, Login>> postLoginOtp(String phoneNumber);

  Future<Either<Failure, Registration>> postRegistrationOtp(
      Registration registration);

  Future<Either<Failure, Driver>> postOtp(Otp otp);

  Future<Either<Failure, Driver>> postOtpResend(Registration registration);

  Future<Either<Failure, Driver>> postPic(XFile pic);

  Future<Either<Failure, Configuration>> putDriver(Driver driver);

  Future<Either<Failure, Driver>> postVehicle(Vehicle vehicle);

  Future<Either<Failure, Driver>> postDocument(DriverDocumentRequest document);

  Future<Either<Failure, Feedbacks>> postFeedback(Feedbacks feedback);

  Future<Either<Failure, AirtimeSuccess>> postAirtime(Service service, double amount);

  Future<Either<Failure, Configuration>> getConfiguration();

  Future<Either<Failure, Driver>> getDriver();

  Future<Either<Failure, WalletTransactions>> getWallet(String? next);

  Future<Either<Failure, Earning>> getEarningsSixMonth();

  Future<Either<Failure, Trip>> getTrip(String? next);

  Future<Either<Failure, double>> getHuluCoinBalance();

  Future<Either<Failure, dynamic>> getService();

  Future<Either<Failure, Earnings>> getEarnings(int pos);

  Future<Either<Failure, Configuration?>> getLogout();

  Future<Either<Failure, String>> getLanguage();

  Future<Either<Failure, bool>> setLanguage(String languageSelected);
}
