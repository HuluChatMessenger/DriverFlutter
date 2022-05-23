import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning_item.dart';

class Earnings extends Equatable {
  Earning? earning;
  List<EarningItem>? earningItem = [];

  Earnings({
    required this.earning,
    required this.earningItem,
  });

  @override
  List<Object?> get props => [
        earning,
        earningItem,
      ];
}
