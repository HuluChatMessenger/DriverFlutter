import 'package:dartz/dartz.dart';
import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/network/network_info.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/local_data_source.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/remote_data_source.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Login>> getLoginOtp(
    String phoneNumber,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final loginOtp = await remoteDataSource.getLoginOtp(phoneNumber);

        print('Request Sent');
        // localDataSource.cacheUser(loginOtp);
        return Right(loginOtp);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // try {
      //   final localLoginOtp = await localDataSource.getLastUser();
      //   return Right(localLoginOtp);
      // } on CacheException {
      //   return Left(CacheFailure());
        return Left(ConnectionFailure());
      // }
    }
  }
}
