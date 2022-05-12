import 'package:hulutaxi_driver/features/login/domain/entities/earning.dart';

class EarningModel extends Earning {
  EarningModel({
    required tripCounts,
    required totalEarnings,
    required totalOnlineHr,
  }) : super(
          tripCounts: tripCounts,
          totalEarnings: totalEarnings,
    totalOnlineHr: totalOnlineHr,
        );

  factory EarningModel.fromJson(Map<String, dynamic> jsonData) {
    String earningsStr = jsonData['total_earnings'].toString();
    String totalHrsStr = jsonData['total_online_hr'].toString();
    double earnings = 0.0;
    double totalHrs = 0.0;

    try {
      earnings = double.parse(earningsStr);
      totalHrs = double.parse(totalHrsStr);
    } catch (e) {
      print('LogHulu earning data: $e');
    }

    return EarningModel(
      tripCounts: jsonData['trip_counts'],
      totalEarnings: earnings,
      totalOnlineHr: totalHrs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "trip_counts": tripCounts,
      "total_earnings": totalEarnings,
      "total_online_hr": totalOnlineHr,
    };
  }
}
