import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class EmptyRegistration extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class LoadingRegistration extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class LoadedRegistration extends RegistrationState {
  final Registration registration;

  const LoadedRegistration({required this.registration});

  @override
  List<Object> get props => [];
}

class ErrorRegistration extends RegistrationState {
  final String message;

  const ErrorRegistration({required this.message});

  @override
  List<Object> get props => [];
}
