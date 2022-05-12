import 'package:equatable/equatable.dart';

class EarningItem extends Equatable {
  final int totalEarning;
  final String label;

  EarningItem({
    required this.totalEarning,
    required this.label,
  });

  @override
  List<Object?> get props => [
        totalEarning,
        label,
      ];
}
