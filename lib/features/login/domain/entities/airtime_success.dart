import 'package:equatable/equatable.dart';

class AirtimeSuccess extends Equatable {
  final double amount;
  final double balance;
  final String phoneNumber;

  const AirtimeSuccess({
    required this.balance,
    required this.amount,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        balance,
        amount,
        phoneNumber,
      ];
}
