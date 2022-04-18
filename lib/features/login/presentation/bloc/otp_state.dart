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
  final Driver driver;

  const LoadedOtp({required this.driver});

  @override
  List<Object> get props => [];
}

class ErrorOtp extends OtpState {
  final String message;

  const ErrorOtp({required this.message});

  @override
  List<Object> get props => [];
}