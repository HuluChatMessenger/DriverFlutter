import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedbackState extends Equatable {
  const FeedbackState();
}

class FeedbackInitial extends FeedbackState {
  @override
  List<Object> get props => [];
}

class EmptyFeedback extends FeedbackState {
  @override
  List<Object?> get props => [];
}

class LoadingFeedback extends FeedbackState {
  @override
  List<Object?> get props => [];
}

class LoadedFeedback extends FeedbackState {

  @override
  List<Object> get props => [];
}

class ErrorFeedback extends FeedbackState {
  final String message;

  const ErrorFeedback({required this.message});

  @override
  List<Object> get props => [];
}
