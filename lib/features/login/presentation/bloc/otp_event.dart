import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

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