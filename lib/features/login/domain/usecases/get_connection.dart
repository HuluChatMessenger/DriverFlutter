import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class GetConnection implements UseCase<dynamic, ParamsConnection> {
  final Repository repository;

  GetConnection(this.repository);

  @override
  Future<Either<Failure, Stream<DataConnectionStatus>>> call(
      ParamsConnection? params) async {
    return repository.getConnectionState();
  }
}

class ParamsConnection extends Equatable {
  const ParamsConnection();

  @override
  List<Object?> get props => [];
}
