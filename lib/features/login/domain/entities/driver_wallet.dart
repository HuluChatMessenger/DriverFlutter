import 'package:equatable/equatable.dart';

class DriverWallet extends Equatable {
  final int id;
  final String balance;

  const DriverWallet({
    required this.id,
    required this.balance,
  });

  @override
  List<Object?> get props => [
        id,
        balance,
      ];
}
