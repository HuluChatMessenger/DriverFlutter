import 'package:hulutaxi_driver/features/login/domain/entities/feedbacks.dart';

class FeedbacksModel extends Feedbacks {
  const FeedbacksModel({
    required feedbackType,
    required urgencyLevel,
    required feedback,
  }) : super(
          feedbackType: feedbackType,
          urgencyLevel: urgencyLevel,
          feedback: feedback,
        );

  factory FeedbacksModel.fromJson(Map<String, dynamic> json) {
    return FeedbacksModel(
      feedbackType: json['type'],
      urgencyLevel: json['urgency'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": feedbackType,
      "urgency": urgencyLevel,
      "feedback": feedback,
    };
  }
}
