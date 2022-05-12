import 'package:hulutaxi_driver/features/login/data/models/trip_item_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip_item.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';

class TripModel extends Trip {
  TripModel({
    required count,
    required next,
    required results,
  }) : super(
          count: count,
          next: next,
          results: results,
        );

  factory TripModel.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> resultsFromJson = jsonData['results'];

    List<TripItem> tripItemList = [];
    for (dynamic element in resultsFromJson) {
      TripItem tripItem = TripItemModel.fromJson(element);
      tripItemList.add(tripItem);
    }

    return TripModel(
      count: jsonData['count'],
      next: jsonData['next'],
      results: tripItemList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "next": next,
      "results": results,
    };
  }
}
