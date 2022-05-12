import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_feedback.dart';

import 'bloc.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final PostFeedback postFeedback;

  FeedbackBloc({required this.postFeedback}) : super(FeedbackInitial()) {
    on<FeedbackEvent>(mapFeedbackState);
  }

  Future<void> mapFeedbackState(
    FeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    if (event is GetFeedback) {
      print('LogHulu Feedback Request started');
      emit(LoadingFeedback());

      final failureOrSuccess =
          await postFeedback(ParamsFeedback(feedback: event.feedback));
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Feedback Response error: $failure  ===|||=== result.');
          return ErrorFeedback(message: _mapFailureToMessage(failure));
        },
        (success) {
          print(
              'LogHulu Feedback Response success: $success  ===|||=== result.');
          return LoadedFeedback();
        },
      ));
    }
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        if (failure is ServerFailure &&
            failure.errMsg != null &&
            failure.errMsg!.isNotEmpty) {
          return failure.errMsg!;
        } else {
          return AppConstants.errMsgServer;
        }
      case ConnectionFailure:
        return AppConstants.errMsgConnection;
      default:
        return AppConstants.errMsgUnknown;
    }
  }
}
