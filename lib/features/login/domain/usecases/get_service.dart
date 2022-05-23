import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetService
    implements UseCase<dynamic, ParamsService> {
  final Repository repository;

  GetService(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(
      ParamsService? params) async {
    return await repository.getService();
  }
}

class ParamsService extends Equatable {
  const ParamsService();

  @override
  List<Object?> get props => [];
}
