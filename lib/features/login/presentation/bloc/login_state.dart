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

class Empty extends LoginState {
  @override
  List<Object?> get props => [];
}

class Loading extends LoginState {
  @override
  List<Object?> get props => [];}

class Loaded extends LoginState {
  final Login login;

  const Loaded({required this.login});

  @override
  List<Object> get props => [];
}

class Error extends LoginState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [];
}
