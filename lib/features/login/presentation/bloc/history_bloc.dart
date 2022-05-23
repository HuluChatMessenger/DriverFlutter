import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip_item.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_history_initial.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_history_next.dart';
import 'package:intl/intl.dart';

import 'bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryInitial getHistoryInitial;
  final GetHistoryNext getHistoryNext;

  HistoryBloc({required this.getHistoryInitial, required this.getHistoryNext})
      : super(HistoryInitial()) {
    on<HistoryEvent>(mapHistoryState);
  }

  Future<void> mapHistoryState(
    HistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    if (event is GetHistoryFirst) {
      print('LogHulu HistoryFirst: Add Request started');
      emit(LoadingHistory());

      final failureOrSuccess = await getHistoryInitial(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response History error');
          return ErrorHistory(
            message: _mapFailureToMessage(failure),
          );
        },
        (success) {
          print('LogHulu Response History received');
          return LoadedHistory(trip: addTitles(success));
        },
      ));
    } else if (event is GetHistory) {
      print('LogHulu HistoryNext: Add Request started');
      emit(LoadingHistoryNext(trip: addTitles(event.trip)));

      final failureOrSuccess =
          await getHistoryNext(ParamsHistoryNext(next: event.nextUrl));
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response wallet error: $failure');
          return ErrorHistoryNext(
              message: _mapFailureToMessage(failure),
              trip: addTitles(event.trip));
        },
        (success) {
          print('LogHulu Response wallet received: $success');
          List<TripItem> results = event.trip.results;
          results.addAll(success.results);
          Trip updatedTrip =
              Trip(count: success.count, next: success.next, results: results);
          return LoadedHistoryNext(trip: addTitles(updatedTrip));
        },
      ));
    }
  }

  Trip addTitles(Trip tripFetched) {
    Trip tripUpdated = tripFetched;
    DateTime date = CommonUtils.getToday();
    bool isTodayTitleSet = false;

    for (TripItem trip in tripFetched.results) {
      String tripDateTextISO = trip.createdAt;
      String tripDateTextFormat = tripDateTextISO.replaceFirst("Z", "+0000");
      DateTime tripDate = CommonUtils.getDateFromStringISO(tripDateTextFormat);

      if (date == null) {
        date = tripDate;
        trip.isSubTitle = true;
      } else if (!CommonUtils.sameDay(tripDate, date)) {
        date = tripDate;
        trip.isSubTitle = true;
      } else {
        trip.isSubTitle = false;
      }

      int time = CommonUtils.getTimeInMill(trip.createdAt);
      DateFormat sdf = DateFormat("d MMMM");
      trip.subTitle =
          sdf.format(DateTime.fromMillisecondsSinceEpoch(time, isUtc: true));

      bool isTitle = false;

      if (tripDate != null &&
          CommonUtils.sameDay(tripDate, CommonUtils.getToday()) &&
          !isTodayTitleSet) {
        isTitle = true;
        isTodayTitleSet = true;
      }

      if (isTitle) {
        trip.isTitle = true;
      } else {
        trip.isTitle = false;
      }
    }

    return tripUpdated;
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        if (failure is ServerFailure &&
            failure.errMsg != null &&
            failure.errMsg!.isNotEmpty) {
          return failure.errMsg!;
        } else {
          return "errMsgServer".tr;
        }
      case ConnectionFailure:
        return "errMsgConnection".tr;
      default:
        return "errMsgUnknown".tr;
    }
  }
}
