import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/network/network_info.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/local_data_source.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/remote_data_source.dart';
import 'package:hulutaxi_driver/features/login/data/models/configuration_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/driver_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/token_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/airtime_success.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_document_request.dart';
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
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';
import 'package:image_picker/image_picker.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Login>> postLoginOtp(
    String phoneNumber,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final loginOtp = await remoteDataSource.postLoginOtp(phoneNumber);
        return Right(loginOtp);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Registration>> postRegistrationOtp(
      Registration registration) async {
    if (await networkInfo.isConnected) {
      try {
        final registrationOtp =
            await remoteDataSource.postRegistrationOtp(registration);
        return Right(registrationOtp);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Driver>> postOtp(Otp otp) async {
    if (await networkInfo.isConnected) {
      try {
        final DriverModel otpResponse;
        if (otp.isRegistration) {
          otpResponse = await remoteDataSource.postOtpRegistration(otp);
        } else {
          otpResponse = await remoteDataSource.postOtpLogin(otp);
        }
        try {
          ConfigurationModel? configuration = await localDataSource.getConfig();
          configuration.isLoggedIn = true;
          print(
              'LogHulu Config OTP: ${configuration.isLoggedIn} |||====||| $configuration');
          localDataSource.cacheConfig(configuration);
        } catch (e) {
          print('LogHulu Config OTP: $e');
        }

        otpResponse.isLoggedIn = true;
        localDataSource.cacheLogin(true);
        if (otpResponse.tokenData != null &&
            otpResponse.tokenData?.access != null) {
          TokenDataModel tokenDataModel =
              TokenDataModel(access: otpResponse.tokenData?.access);
          localDataSource.cacheToken(tokenDataModel);
        }
        localDataSource.cacheDriver(otpResponse);
        return Right(otpResponse);
      } catch (e) {
        print("LogHulu OTP: $e");
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, DriverModel>> postOtpResend(
      Registration registration) async {
    if (await networkInfo.isConnected) {
      try {
        DriverModel driver =
            await remoteDataSource.postOtpResendRegistration(registration);
        return Right(driver);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Configuration>> getConfiguration() async {
    if (await networkInfo.isConnected) {
      ConfigurationModel? configuration;
      try {
        configuration = await remoteDataSource.getConfiguration();
        configuration.isLoggedIn = await localDataSource.getLogin();
        localDataSource.cacheConfig(configuration);
        return Right(configuration);
      } on LogoutException {
        try {
          await localDataSource.clearData();
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          localDataSource.cacheLogin(false);
          return Left(LogoutFailure(configuration: configurationLogout));
        } on CacheException {
          return Left(ServerFailure(null));
        }
      } catch (e) {
        print('Configuration: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Driver>> getDriver() async {
    if (await networkInfo.isConnected) {
      try {
        final driver = await remoteDataSource.getDriver();

        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
        } catch (e) {
          print('LogHulu CacheExceptionDriver: $e');
        }
        localDataSource.cacheDriver(driver);
        return Right(driver);
      } on LogoutException {
        try {
          await localDataSource.clearData();
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          localDataSource.cacheLogin(false);
          return Left(LogoutFailure(configuration: configurationLogout));
        } on CacheException {
          return Left(ServerFailure(null));
        }
      } catch (e) {
        print('LogHulu Driver: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      try {
        final localDriver = await localDataSource.getDriver();
        return Right(localDriver);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Driver>> postDocument(
      DriverDocumentRequest document) async {
    if (await networkInfo.isConnected) {
      try {
        final driver = await remoteDataSource.postDocument(document);

        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
        } catch (e, s) {
          print('LogHulu CacheExceptionDriver: ' +
              e.toString() +
              " | " +
              s.toString());
        }
        localDataSource.cacheDriver(driver);
        return Right(driver);
      } on LogoutException {
        try {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          return Left(LogoutFailure(configuration: configurationLogout));
        } on CacheException {
          return Left(ServerFailure(null));
        }
      } catch (e) {
        print('LogHulu Driver: ' + e.toString());
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Configuration>> putDriver(Driver driverRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final driver = await remoteDataSource.putDriver(driverRequest);

        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
        } catch (e, s) {
          print('LogHulu CacheExceptionDriver: ' +
              e.toString() +
              " | " +
              s.toString());
        }
        localDataSource.cacheDriver(driver);
        try {
          final failureOrSuccessConfig = await getConfiguration();
          failureOrSuccessConfig.fold(
            (failure) {
              return Left(ServerFailure(null));
            },
            (success) {
              return Right(success);
            },
          );
        } on CacheException {
          return Left(CacheFailure());
        }
        final configuration = await localDataSource.getConfig();
        configuration.isLoggedIn = await localDataSource.getLogin();

        return Right(configuration);
      } on LogoutException {
        try {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          localDataSource.cacheLogin(false);
          return Left(LogoutFailure(configuration: configurationLogout));
        } on CacheException {
          return Left(ServerFailure(null));
        }
      } catch (e) {
        print('LogHulu Driver: ' + e.toString());
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Driver>> postPic(XFile pic) async {
    if (await networkInfo.isConnected) {
      try {
        final picResult = await remoteDataSource.postPic(pic);
        final driver = await localDataSource.getDriver();
        driver.profilePic = picResult;
        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
        } catch (e, s) {
          print('LogHulu CacheExceptionDriver: ' +
              e.toString() +
              " | " +
              s.toString());
        }
        localDataSource.cacheDriver(driver);
        return Right(driver);
      } on LogoutException {
        try {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          return Left(LogoutFailure(configuration: configurationLogout));
        } on CacheException {
          return Left(ServerFailure(null));
        }
      } catch (e) {
        print('LogHulu PicImplError: ' + e.toString());
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Driver>> postVehicle(Vehicle vehicle) async {
    if (await networkInfo.isConnected) {
      try {
        final vehicleResult = await remoteDataSource.postVehicle(vehicle);
        final driver = await localDataSource.getDriver();
        driver.vehicle = vehicleResult;
        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
        } catch (e, s) {
          print('LogHulu CacheExceptionDriver: ' +
              e.toString() +
              " | " +
              s.toString());
        }
        return Right(driver);
      } on LogoutException {
        try {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          return Left(LogoutFailure(configuration: configurationLogout));
        } on CacheException {
          return Left(ServerFailure(null));
        }
      } catch (e) {
        print('LogHulu Driver: ' + e.toString());
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Feedbacks>> postFeedback(Feedbacks feedback) async {
    if (await networkInfo.isConnected) {
      try {
        final feedbackResult = await remoteDataSource.postFeedback(feedback);
        return Right(feedbackResult);
      } on LogoutException {
        try {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          return Left(LogoutFailure(configuration: configurationLogout));
        } on CacheException {
          return Left(ServerFailure(null));
        }
      } catch (e) {
        print('LogHulu Driver: ' + e.toString());
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, WalletTransactions>> getWallet(String? next) async {
    if (await networkInfo.isConnected) {
      try {
        final transactions = await remoteDataSource.getWallet(next);
        return Right(transactions);
      } catch (e) {
        print('LogHulu Wallet: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Earning>> getEarningsSixMonth() async {
    if (await networkInfo.isConnected) {
      try {
        final earnings = await remoteDataSource.getEarningMonthSix();
        return Right(earnings);
      } catch (e) {
        print('LogHulu Wallet: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Trip>> getTrip(String? next) async {
    if (await networkInfo.isConnected) {
      try {
        final trips = await remoteDataSource.getTrip(next);
        return Right(trips);
      } catch (e) {
        print('LogHulu Trips: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, double>> getHuluCoinBalance() async {
    if (await networkInfo.isConnected) {
      try {
        final balance = await remoteDataSource.getHuluCoinBalance();
        return Right(balance);
      } catch (e) {
        print('LogHulu HuluCoin balance: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> getService() async {
    if (await networkInfo.isConnected) {
      try {
        final services = await remoteDataSource.getServices();
        return Right(services);
      } catch (e) {
        print('LogHulu Services: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AirtimeSuccess>> postAirtime(
      Service service, double amount) async {
    if (await networkInfo.isConnected) {
      try {
        String? phoneNumber;
        final Driver? driver = await localDataSource.getDriver();

        if (driver?.phoneNumber != null) {
          phoneNumber = driver?.phoneNumber;
        } else {
          throw LogoutException();
        }
        final updatedBalance =
            await remoteDataSource.postAirtime(service, amount, phoneNumber!);
        AirtimeSuccess success = AirtimeSuccess(
            balance: updatedBalance, amount: amount, phoneNumber: phoneNumber);
        return Right(success);
      } catch (e) {
        print('LogHulu Airtime: $e');
        if (e is LogoutException) {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          return Left(LogoutFailure(configuration: configurationLogout));
        } else if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Earnings>> getEarnings(int pos) async {
    if (await networkInfo.isConnected) {
      try {
        Earnings earningsResult = Earnings(earning: null, earningItem: []);
        if (pos == 0) {
          final earnings = await remoteDataSource.getEarningWeek();
          earningsResult.earning = earnings;
          try {
            final earningItems = await remoteDataSource.getEarningsListWeek();
            earningsResult.earningItem = earningItems;
          } catch (e) {
            print('LogHulu Earnings Week: $e');
            if (e is ServerException) {
              return Left(ServerFailure(e.errMsg));
            } else {
              return Left(ServerFailure(null));
            }
          }
        } else if (pos == 1) {
          final earnings = await remoteDataSource.getEarningWeekTwo();
          earningsResult.earning = earnings;
          try {
            final earningItems =
                await remoteDataSource.getEarningsListWeekTwo();
            earningsResult.earningItem = earningItems;
          } catch (e) {
            print('LogHulu Earnings Week Two: $e');
            if (e is ServerException) {
              return Left(ServerFailure(e.errMsg));
            } else {
              return Left(ServerFailure(null));
            }
          }
        } else if (pos == 2) {
          final earnings = await remoteDataSource.getEarningMonth();
          earningsResult.earning = earnings;
          try {
            final earningItems = await remoteDataSource.getEarningsListMonth();
            earningsResult.earningItem = earningItems;
          } catch (e) {
            print('LogHulu Earnings Month: $e');
            if (e is ServerException) {
              return Left(ServerFailure(e.errMsg));
            } else {
              return Left(ServerFailure(null));
            }
          }
        } else if (pos == 3) {
          final earnings = await remoteDataSource.getEarningMonthThree();
          earningsResult.earning = earnings;
          try {
            final earningItems =
                await remoteDataSource.getEarningsListMonthThree();
            earningsResult.earningItem = earningItems;
          } catch (e) {
            print('LogHulu Earnings Month Three: $e');
            if (e is ServerException) {
              return Left(ServerFailure(e.errMsg));
            } else {
              return Left(ServerFailure(null));
            }
          }
        } else if (pos == 4) {
          final earnings = await remoteDataSource.getEarningMonthSix();
          earningsResult.earning = earnings;
          try {
            final earningItems =
                await remoteDataSource.getEarningsListMonthSix();
            earningsResult.earningItem = earningItems;
          } catch (e) {
            print('LogHulu Earnings Month Six: $e');
            if (e is ServerException) {
              return Left(ServerFailure(e.errMsg));
            } else {
              return Left(ServerFailure(null));
            }
          }
        }
        print('LogHulu Earning result: $earningsResult');
        return Right(earningsResult);
      } catch (e) {
        print('LogHulu Earnings: $e');
        if (e is ServerException) {
          return Left(ServerFailure(e.errMsg));
        } else {
          return Left(ServerFailure(null));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Configuration?>> getLogout() async {
    try {
      final Configuration? configuration = await localDataSource.getConfig();
      await localDataSource.clearData();
      return Right(configuration);
    } catch (e) {
      print('LogHulu Logout: $e');
      if (e is LogoutException) {
        ConfigurationModel? configurationLogout =
            await localDataSource.getConfig();
        return Right(configurationLogout);
      } else if (e is ServerException) {
        return Left(ServerFailure(e.errMsg));
      } else {
        return Left(ServerFailure(null));
      }
    }
  }

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final String language = await localDataSource.getLanguage();
      return Right(language);
    } catch (e) {
      print('LogHulu get language: $e');
      return Right(AppConstants.languageAm);
    }
  }

  @override
  Future<Either<Failure, bool>> setLanguage(String languageSelected) async {
    try {
      localDataSource.cacheLanguage(languageSelected);
      return const Right(true);
    } catch (e) {
      print('LogHulu set language: $e');
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, Stream<DataConnectionStatus>>>
      getConnectionState() async {
    return Right(networkInfo.isConnectionState);
  }
}
