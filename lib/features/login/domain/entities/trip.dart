import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip_item.dart';

class Trip extends Equatable {
  final int count;
  final String next;
  final List<TripItem> results;

  const Trip({
    required this.count,
    required this.next,
    required this.results,
  });

  @override
  List<Object?> get props => [
        count,
        next,
        results,
      ];
}
