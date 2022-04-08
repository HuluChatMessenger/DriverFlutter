import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent([List props = const <dynamic>[]]);
}

class GetOTPForLogin extends LoginEvent {
  final String phoneNumber;

  GetOTPForLogin(this.phoneNumber) : super([phoneNumber]);

  @override
  List<Object> get props => [phoneNumber];
}
