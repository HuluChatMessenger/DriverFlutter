import 'package:equatable/equatable.dart';

class Rider extends Equatable {
  final int id;
  final String phoneNumber;
  final String firstName;
  final String lastName;

  const Rider({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [
        id,
        phoneNumber,
        firstName,
        lastName,
      ];
}
