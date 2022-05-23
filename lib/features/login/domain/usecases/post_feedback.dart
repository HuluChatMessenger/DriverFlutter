import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/feedbacks.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostFeedback implements UseCase<Feedbacks, ParamsFeedback> {
  final Repository repository;

  PostFeedback(this.repository);

  @override
  Future<Either<Failure, Feedbacks>> call(ParamsFeedback params) async {
    return await repository.postFeedback(params.feedback);
  }
}

class ParamsFeedback extends Equatable {
  final Feedbacks feedback;

  const ParamsFeedback({
    required this.feedback,
  });

  @override
  List<Object?> get props => [feedback];
}
