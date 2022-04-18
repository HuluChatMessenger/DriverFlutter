import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WaitingState extends Equatable {
  const WaitingState();
}

class WaitingInitial extends WaitingState {
  @override
  List<Object> get props => [];
}

class EmptyWaiting extends WaitingState {
  @override
  List<Object?> get props => [];
}

class LoadingWaiting extends WaitingState {
  @override
  List<Object?> get props => [];
}

class LoadedWaiting extends WaitingState {
  final Driver driver;

  const LoadedWaiting({required this.driver});

  @override
  List<Object> get props => [];
}

class ErrorWaiting extends WaitingState {
  final String message;

  const ErrorWaiting({required this.message});

  @override
  List<Object> get props => [];
}
