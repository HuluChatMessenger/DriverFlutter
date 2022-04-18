import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostPic implements UseCase<Driver, Params> {
  final Repository repository;

  PostPic(this.repository);

  @override
  Future<Either<Failure, Driver>> call(Params params) async {
    return await repository.postPic(params.pic);
  }
}

class Params extends Equatable {
  final String pic;

  const Params({required this.pic});

  @override
  List<Object?> get props => [pic];
}
