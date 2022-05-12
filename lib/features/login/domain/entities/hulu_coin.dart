import 'package:equatable/equatable.dart';

class HuluCoin extends Equatable {
  final double balance;

  const HuluCoin({
    required this.balance,
  });

  @override
  List<Object?> get props => [
        balance,
      ];
}
