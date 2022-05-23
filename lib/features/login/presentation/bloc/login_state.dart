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
  String? phoneNumber;

  EmptyLogin({this.phoneNumber});

  @override
  List<Object?> get props => [];
}

class LoadingLogin extends LoginState {
  String? phoneNumber;

  LoadingLogin({this.phoneNumber});

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
  String? phoneNumber;

  ErrorLogin({required this.message, this.phoneNumber});

  @override
  List<Object> get props => [];
}
