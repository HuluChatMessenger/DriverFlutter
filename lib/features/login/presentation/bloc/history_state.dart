import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class EmptyHistory extends HistoryState {
  @override
  List<Object?> get props => [];
}

class LoadingHistory extends HistoryState {
  @override
  List<Object?> get props => [];
}

class LoadingHistoryNext extends HistoryState {
  final Trip trip;

  LoadingHistoryNext({required this.trip});

  @override
  List<Object?> get props => [];
}

class LoadedHistory extends HistoryState {
  final Trip trip;

  LoadedHistory({required this.trip});

  @override
  List<Object> get props => [];
}

class LoadedHistoryNext extends HistoryState {
  final Trip trip;

  LoadedHistoryNext({required this.trip});

  @override
  List<Object> get props => [];
}

class ErrorHistory extends HistoryState {
  final String message;

  ErrorHistory({required this.message});

  @override
  List<Object> get props => [];
}

class ErrorHistoryNext extends HistoryState {
  final String message;
  final Trip trip;

  ErrorHistoryNext({required this.message, required this.trip});

  @override
  List<Object> get props => [];
}
