import 'package:equatable/equatable.dart';

class Feedbacks extends Equatable {
  final String feedbackType;
  final String urgencyLevel;
  final String feedback;

  const Feedbacks({
    required this.feedbackType,
    required this.urgencyLevel,
    required this.feedback,
  });

  @override
  List<Object?> get props => [
        feedbackType,
        urgencyLevel,
        feedback,
      ];
}
