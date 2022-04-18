import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/data/models/configuration_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

//General failures
class ServerFailure extends Failure {
  String? errMsg;

  ServerFailure(this.errMsg);
}

class LogoutFailure extends Failure {
  final ConfigurationModel configuration;

  LogoutFailure({required this.configuration});
}

class CacheFailure extends Failure {}

class ConnectionFailure extends Failure {}
