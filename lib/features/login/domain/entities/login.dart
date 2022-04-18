import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final int id;
  final String phoneNumber;

  const Login({
    required this.id,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        id,
        phoneNumber,
      ];
}
