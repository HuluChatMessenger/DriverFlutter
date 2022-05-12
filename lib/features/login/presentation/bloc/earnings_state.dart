import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EarningsState extends Equatable {
  const EarningsState();
}

class EarningsInitial extends EarningsState {
  @override
  List<Object> get props => [];
}

class EmptyEarnings extends EarningsState {
  @override
  List<Object?> get props => [];
}

class LoadingEarningsFirst extends EarningsState {
  @override
  List<Object?> get props => [];
}

class LoadingEarnings extends EarningsState {
  final int selectedPosition;
  final List<Earnings> earnings;

  LoadingEarnings({required this.selectedPosition, required this.earnings});

  @override
  List<Object?> get props => [];
}

class LoadedEarnings extends EarningsState {
  final int selectedPosition;
  final List<Earnings> earnings;

  LoadedEarnings({required this.selectedPosition, required this.earnings});

  @override
  List<Object> get props => [];
}

class ErrorEarnings extends EarningsState {
  final String message;
  final int selectedPosition;
  final List<Earnings> earnings;

  ErrorEarnings(
      {required this.message,
      required this.selectedPosition,
      required this.earnings});

  @override
  List<Object> get props => [];
}
