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
  Registration? registration;

  EmptyRegistration({this.registration});

  @override
  List<Object?> get props => [];
}

class LoadingRegistration extends RegistrationState {
  Registration? registration;

  LoadingRegistration({this.registration});

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
  Registration? registration;
  final String message;

  ErrorRegistration({required this.message, this.registration});

  @override
  List<Object> get props => [];
}
