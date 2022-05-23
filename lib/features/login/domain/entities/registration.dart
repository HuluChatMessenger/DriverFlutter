import 'package:equatable/equatable.dart';

class Registration extends Equatable {
  final int id;
  final String firstName;
  final String fatherName;
  final String grandfatherName;
  final String phoneNumber;
  String? referralCode;
  bool? isTerms;

  Registration({
    required this.id,
    required this.firstName,
    required this.fatherName,
    required this.grandfatherName,
    required this.phoneNumber,
    this.referralCode,
    this.isTerms,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        fatherName,
        grandfatherName,
        phoneNumber,
        referralCode,
        isTerms,
      ];
}
