import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OtpEvent extends Equatable {
  const OtpEvent([List props = const <dynamic>[]]);
}

class GetOTP extends OtpEvent {
  final Otp otp;

  GetOTP(this.otp) : super([otp]);

  @override
  List<Object> get props => [otp];
}

class ResendOTPRegistration extends OtpEvent {
  final Registration registration;

  ResendOTPRegistration(this.registration) : super([registration]);

  @override
  List<Object?> get props => [registration];
}

class ResendOTPLogin extends OtpEvent {
  final String phoneNumber;

  ResendOTPLogin(this.phoneNumber) : super([phoneNumber]);

  @override
  List<Object> get props => [phoneNumber];
}
