import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NetworkState extends Equatable {
  const NetworkState();
}

class NetworkInitial extends NetworkState {
  @override
  List<Object> get props => [];
}

class NetworkSuccess extends NetworkState {

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends NetworkState {

  @override
  List<Object?> get props => [];
}
