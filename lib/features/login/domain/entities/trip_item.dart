import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/rider.dart';

class TripItem extends Equatable {
  final int id;
  final int driverRating;
  final int riderRating;
  bool? isTitle;
  bool? isSubTitle;
  String? subTitle;
  final String transType;
  final String reason;
  final String status;
  final String distance;
  final String price;
  final String createdAt;
  final String startedAt;
  final String dropOffStreetName;
  final String pickUpStreetName;
  final String pickUpDisplayName;
  final String dropOffDisplayName;
  final String duration;
  final String durationText;
  final String distanceText;
  final Rider rider;

  TripItem({
    required this.id,
    required this.driverRating,
    required this.riderRating,
    this.isTitle,
    this.isSubTitle,
    this.subTitle,
    required this.transType,
    required this.reason,
    required this.status,
    required this.distance,
    required this.price,
    required this.createdAt,
    required this.startedAt,
    required this.dropOffStreetName,
    required this.pickUpStreetName,
    required this.pickUpDisplayName,
    required this.dropOffDisplayName,
    required this.duration,
    required this.durationText,
    required this.distanceText,
    required this.rider,
  });

  @override
  List<Object?> get props => [
        id,
        driverRating,
        riderRating,
        isTitle,
        isSubTitle,
        subTitle,
        transType,
        reason,
        status,
        distance,
        price,
        createdAt,
        startedAt,
        dropOffStreetName,
        pickUpStreetName,
        pickUpDisplayName,
        dropOffDisplayName,
        duration,
        durationText,
        distanceText,
        rider,
      ];
}
