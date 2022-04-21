import 'package:dartz/dartz.dart';
import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/network/network_info.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/local_data_source.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/remote_data_source.dart';
import 'package:hulutaxi_driver/features/login/data/models/configuration_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/driver_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
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
        localDataSource.cacheDriver(otpResponse);

        try {
          ConfigurationModel configurationModel =
              await localDataSource.getConfig();
          DriverModel driver = await localDataSource.getDriver();
          print(
              'LogHulu Config OTP: ${configurationModel.isLoggedIn} |||====||| $configurationModel');
          print('LogHulu Driver OTP: ${driver.isLoggedIn} |||====||| $driver');
        } catch (e) {
          print('LogHulu Config Driver OTP: $e');
        }

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

        bool isLoggedIn = false;
        try {
          Driver? driver = await localDataSource.getDriver();
          isLoggedIn = driver.isLoggedIn == true;
          print(
              'LogHulu Driver Config: ${driver.isLoggedIn} |||====||| $driver ======result. ');
        } catch (e) {
          print('LogHulu DriverConfig: $e');
        }
        configuration.isLoggedIn = isLoggedIn;
        localDataSource.cacheConfig(configuration);
        return Right(configuration);
      } on LogoutException {
        try {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
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
          driver.isPicSubmitted = driver.profilePic?.photo != null;
        } catch (e) {
          print('LogHulu CacheExceptionDriver: $e');
        }
        bool isLoggedIn = false;
        try {
          Driver? driverCache = await localDataSource.getDriver();
          isLoggedIn = driverCache.isLoggedIn == true;
        } catch (e) {
          print('LogHulu Driver: $e');
        }
        driver.isLoggedIn = isLoggedIn;
        localDataSource.cacheDriver(driver);
        return Right(driver);
      } on LogoutException {
        try {
          ConfigurationModel? configurationLogout =
              await localDataSource.getConfig();
          configurationLogout.isLoggedIn = false;
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
  Future<Either<Failure, Driver>> postDocument(DriverDocuments document) async {
    if (await networkInfo.isConnected) {
      try {
        final driver = await remoteDataSource.postDocument(document);

        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
          driver.isPicSubmitted = driver.profilePic?.photo != null;
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
      try {
        final localDriver = await localDataSource.getDriver();
        return Right(localDriver);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Driver>> putDriver(Driver driverRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final driver = await remoteDataSource.putDriver(driverRequest);

        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
          driver.isPicSubmitted = driver.profilePic?.photo != null;
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
      try {
        final localDriver = await localDataSource.getDriver();
        return Right(localDriver);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Driver>> postPic(XFile pic) async {
    if (await networkInfo.isConnected) {
      try {
        final driver = await remoteDataSource.postPic(pic);

        try {
          final configuration = await localDataSource.getConfig();
          bool documentSubmitted = false;
          int docsSize = configuration.documentTypes.length - 1;
          List<String> reqType = [];
          int allSubmitted = 0;
          for (int i = 0; i < docsSize; i++) {
            int posReq = configuration.documentTypes.elementAt(i).length - 1;
            if (configuration.documentTypes.elementAt(i).elementAt(posReq) ==
                "true") {
              reqType
                  .add(configuration.documentTypes.elementAt(i).elementAt(0));
            }
          }
          if (driver.driverDocuments != null) {
            for (DriverDocuments document in driver.driverDocuments!) {
              for (String typeRequired in reqType) {
                if (document.documentType == typeRequired) {
                  allSubmitted++;
                }
              }
            }
          }
          if (reqType.length == allSubmitted) {
            documentSubmitted = true;
          }
          driver.isDocumentSubmitted = documentSubmitted;
          driver.isPicSubmitted = driver.profilePic != null;
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
      try {
        final localDriver = await localDataSource.getDriver();
        return Right(localDriver);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Driver>> postVehicle(Vehicle vehicle) async {
    if (await networkInfo.isConnected) {
      try {
        final driver = await remoteDataSource.postVehicle(vehicle);

        try {
          final configuration = await localDataSource.getConfig();
          driver.isDocumentSubmitted = CommonUtils().checkDocsSubmitted(
              configuration.documentTypes, driver.driverDocuments);
          driver.isPicSubmitted = driver.profilePic?.photo != null;
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
      try {
        final localDriver = await localDataSource.getDriver();
        return Right(localDriver);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
