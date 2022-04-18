import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/login.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();
}


class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class EmptyLogin extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoadingLogin extends LoginState {
  @override
  List<Object?> get props => [];}

class LoadedLogin extends LoginState {
  final String phoneNumber;

  const LoadedLogin({required this.phoneNumber});

  @override
  List<Object> get props => [];
}

class ErrorLogin extends LoginState {
  final String message;

  const ErrorLogin({required this.message});

  @override
  List<Object> get props => [];
}
