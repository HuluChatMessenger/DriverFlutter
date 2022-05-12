import 'package:equatable/equatable.dart';

class Earning extends Equatable {
  final int tripCounts;
  final double totalEarnings;
  final double totalOnlineHr;

  Earning({
    required this.tripCounts,
    required this.totalEarnings,
    required this.totalOnlineHr,
  });

  @override
  List<Object?> get props => [
        tripCounts,
        totalEarnings,
    totalOnlineHr,
      ];
}
