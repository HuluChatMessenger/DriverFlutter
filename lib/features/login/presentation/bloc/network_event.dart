import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NetworkEvent extends Equatable {
  const NetworkEvent([List props = const <dynamic>[]]);
}

class ListenConnection extends NetworkEvent {
  const ListenConnection() : super();

  @override
  List<Object> get props => [];
}

class ConnectionChanged extends NetworkEvent {
  NetworkState connection;

  ConnectionChanged(this.connection) : super([connection]);

  @override
  List<Object> get props => [connection];
}
