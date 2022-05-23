import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/feedbacks.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent([List props = const <dynamic>[]]);
}

class GetFeedback extends FeedbackEvent {
  final Feedbacks feedback;

  GetFeedback(
    this.feedback,
  ) : super([feedback]);

  @override
  List<Object> get props => [feedback];
}
