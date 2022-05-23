import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetHistoryInitial
    implements UseCase<Trip, ParamsHistoryInitial> {
  final Repository repository;

  GetHistoryInitial(this.repository);

  @override
  Future<Either<Failure, Trip>> call(
      ParamsHistoryInitial? params) async {
    return await repository.getTrip(null);
  }
}

class ParamsHistoryInitial extends Equatable {
  const ParamsHistoryInitial();

  @override
  List<Object?> get props => [];
}
