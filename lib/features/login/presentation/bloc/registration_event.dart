import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationEvent extends Equatable  {
  const RegistrationEvent([List props = const <dynamic>[]]);
}

class GetOTPForRegistration extends RegistrationEvent {
  final Registration registration;

  GetOTPForRegistration(this.registration) : super([registration]);

  @override
  List<Object?> get props => [registration];
}
