import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  const HistoryEvent([List props = const <dynamic>[]]);
}

class GetHistoryFirst extends HistoryEvent {
  GetHistoryFirst() : super();

  @override
  List<Object> get props => [];
}

class GetHistory extends HistoryEvent {
  final String nextUrl;
  final Trip trip;

  GetHistory(this.nextUrl, this.trip) : super([nextUrl, trip]);

  @override
  List<Object> get props => [nextUrl, trip];
}
