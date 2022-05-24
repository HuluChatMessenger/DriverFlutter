import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/driver.dart';

@immutable
abstract class OtpState extends Equatable {
  const OtpState();}


class OtpInitial extends OtpState {
  @override
  List<Object> get props => [];
}

class EmptyOtp extends OtpState {
  @override
  List<Object?> get props => [];
}

class LoadingOtp extends OtpState {
  @override
  List<Object?> get props => [];}

class LoadedOtp extends OtpState {

  @override
  List<Object> get props => [];
}

class LoadedOtpResendLogin extends OtpState {
  final String phoneNumber;

  const LoadedOtpResendLogin({required this.phoneNumber});

  @override
  List<Object> get props => [];
}

class LoadedOtpResendRegistration extends OtpState {
  final Registration registration;

  const LoadedOtpResendRegistration({required this.registration});

  @override
  List<Object> get props => [];
}

class ErrorOtp extends OtpState {
  final String message;

  const ErrorOtp({required this.message});

  @override
  List<Object> get props => [];
}