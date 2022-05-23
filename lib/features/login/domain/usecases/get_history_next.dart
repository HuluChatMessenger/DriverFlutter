import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetHistoryNext implements UseCase<Trip, ParamsHistoryNext> {
  final Repository repository;

  GetHistoryNext(this.repository);

  @override
  Future<Either<Failure, Trip>> call(
      ParamsHistoryNext params) async {
    return await repository.getTrip(params.next);
  }
}

class ParamsHistoryNext extends Equatable {
  final String next;

  const ParamsHistoryNext({required this.next});

  @override
  List<Object?> get props => [next];
}
