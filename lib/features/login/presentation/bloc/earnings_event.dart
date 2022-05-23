import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EarningsEvent extends Equatable {
  const EarningsEvent([List props = const <dynamic>[]]);
}

class GetEarningsFirst extends EarningsEvent {
  @override
  List<Object> get props => [];
}

class GetEarningsLoad extends EarningsEvent {
  final int selectedEarning;
  final List<Earnings> earnings;

  GetEarningsLoad(this.selectedEarning, this.earnings)
      : super([selectedEarning, earnings]);

  @override
  List<Object> get props => [selectedEarning, earnings];
}
