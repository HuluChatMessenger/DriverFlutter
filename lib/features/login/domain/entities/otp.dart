import 'package:equatable/equatable.dart';

class Otp extends Equatable {
  final String otp;
  final String phoneNumber;
  final bool isRegistration;

  const Otp({
    required this.otp,
    required this.phoneNumber,
    required this.isRegistration,
  });

  @override
  List<Object?> get props => [
        otp,
        phoneNumber,
        isRegistration,
      ];
}
