import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_earnings.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_earnings_initial.dart';

import 'bloc.dart';

class EarningsBloc extends Bloc<EarningsEvent, EarningsState> {
  final GetEarningsInitial getEarningsInitial;
  final GetEarnings getEarnings;

  EarningsBloc({required this.getEarningsInitial, required this.getEarnings}) : super(EarningsInitial()) {
    on<EarningsEvent>(mapEarningState);
  }

  Future<void> mapEarningState(
    EarningsEvent event,
    Emitter<EarningsState> emit,
  ) async {
    if (event is GetEarningsFirst) {
      print('LogHulu EarningFirst: Add Request started');
      emit(LoadingEarningsFirst());

      final failureOrSuccess = await getEarningsInitial(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response error');
          List<Earnings> earnings = [
            Earnings(earning: null, earningItem: []),
            Earnings(earning: null, earningItem: []),
            Earnings(earning: null, earningItem: []),
            Earnings(earning: null, earningItem: []),
            Earnings(earning: null, earningItem: []),
          ];
          return ErrorEarnings(
            earnings: earnings,
            selectedPosition: 0,
            message: _mapFailureToMessage(failure),
          );
        },
        (success) {
          print('LogHulu Response received');
          List<Earnings> earnings = [
            success,
            Earnings(earning: null, earningItem: []),
            Earnings(earning: null, earningItem: []),
            Earnings(earning: null, earningItem: []),
            Earnings(earning: null, earningItem: []),
          ];
          return LoadedEarnings(earnings: earnings, selectedPosition: 0);
        },
      ));
    } else if (event is GetEarningsLoad) {
      print('LogHulu EarningNext: Add Request started');
      emit(LoadingEarnings(
          earnings: event.earnings, selectedPosition: event.selectedEarning));

      final failureOrSuccess = await getEarnings(
          ParamsEarnings(type: event.selectedEarning));
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response earning error: $failure');
          return ErrorEarnings(
              message: _mapFailureToMessage(failure),
              earnings: event.earnings,
              selectedPosition: event.selectedEarning);
        },
        (success) {
          print('LogHulu Response earning received: $success');

          List<Earnings> earnings = event.earnings;

          if (event.selectedEarning == 0) {
            earnings = [
              success,
              event.earnings.elementAt(1),
              event.earnings.elementAt(2),
              event.earnings.elementAt(3),
              event.earnings.elementAt(4),
            ];
          } else if (event.selectedEarning == 1) {
            earnings = [
              event.earnings.elementAt(0),
              success,
              event.earnings.elementAt(2),
              event.earnings.elementAt(3),
              event.earnings.elementAt(4),
            ];
          } else if (event.selectedEarning == 2) {
            earnings = [
              event.earnings.elementAt(1),
              event.earnings.elementAt(2),
              success,
              event.earnings.elementAt(3),
              event.earnings.elementAt(4),
            ];
          } else if (event.selectedEarning == 3) {
            earnings = [
              event.earnings.elementAt(0),
              event.earnings.elementAt(1),
              event.earnings.elementAt(2),
              success,
              event.earnings.elementAt(4),
            ];
          } else if (event.selectedEarning == 4) {
            earnings = [
              event.earnings.elementAt(0),
              event.earnings.elementAt(1),
              event.earnings.elementAt(2),
              event.earnings.elementAt(3),
              success,
            ];
          }
          return LoadedEarnings(
              earnings: earnings, selectedPosition: event.selectedEarning);
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
