import 'package:hulutaxi_driver/features/login/data/models/rider_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip_item.dart';

class TripItemModel extends TripItem {
  TripItemModel({
    required id,
    required driverRating,
    required riderRating,
    required transType,
    required reason,
    required status,
    required distance,
    required price,
    required createdAt,
    required startedAt,
    required dropOffStreetName,
    required pickUpStreetName,
    required pickUpDisplayName,
    required dropOffDisplayName,
    required duration,
    required durationText,
    required distanceText,
    required rider,
  }) : super(
          id: id,
          driverRating: driverRating,
          riderRating: riderRating,
          transType: transType,
          reason: reason,
          status: status,
          distance: distance,
          price: price,
          createdAt: createdAt,
          startedAt: startedAt,
          dropOffStreetName: dropOffStreetName,
          pickUpStreetName: pickUpStreetName,
          pickUpDisplayName: pickUpDisplayName,
          dropOffDisplayName: dropOffDisplayName,
          duration: duration,
          durationText: durationText,
          distanceText: distanceText,
          rider: rider,
        );

  factory TripItemModel.fromJson(Map<String, dynamic> jsonData) {
    return TripItemModel(
      id: jsonData['id'],
      driverRating: jsonData['driver_rating'],
      riderRating: jsonData['rider_rating'],
      transType: jsonData['trans_type'],
      reason: jsonData['reason'],
      status: jsonData['status'],
      distance: jsonData['distance'].toString(),
      price: jsonData['price'],
      createdAt: jsonData['created_at'],
      startedAt: jsonData['started_at'],
      dropOffStreetName: jsonData['drop_off_street_name'],
      pickUpStreetName: jsonData['pick_up_street_name'],
      pickUpDisplayName: jsonData['pick_up_display_name'],
      dropOffDisplayName: jsonData['drop_off_display_name'],
      duration: jsonData['duration'],
      durationText: jsonData['duration_text'],
      distanceText: jsonData['distance_text'],
      rider: RiderModel.fromJson(jsonData['rider']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "trans_type": transType,
      "reason": reason,
      "status": status,
      "driver_rating": driverRating,
      "rider_rating": riderRating,
      "distance": distance,
      "price": price,
      "created_at": createdAt,
      "started_at": startedAt,
      "drop_off_street_name": dropOffStreetName,
      "pick_up_street_name": pickUpStreetName,
      "pick_up_display_name": pickUpDisplayName,
      "drop_off_display_name": dropOffDisplayName,
      "duration": duration,
      "duration_text": durationText,
      "distance_text": distanceText,
      "rider": rider,
    };
  }
}
