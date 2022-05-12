import 'package:hulutaxi_driver/features/login/domain/entities/earning_item.dart';

class EarningItemModel extends EarningItem {
  EarningItemModel({
    required totalEarning,
    required label,
  }) : super(
          totalEarning: totalEarning,
          label: label,
        );

  factory EarningItemModel.fromJson(Map<String, dynamic> jsonData) {
    return EarningItemModel(
      totalEarning: jsonData['total_earning'],
      label: jsonData['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total_earning": totalEarning,
      "label": label,
    };
  }
}
