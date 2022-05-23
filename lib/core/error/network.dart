import 'package:equatable/equatable.dart';

abstract class NetworkStates extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectionFailure extends NetworkStates {}

class ConnectionSuccess extends NetworkStates {}
