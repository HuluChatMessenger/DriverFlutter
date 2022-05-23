import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_hulu_coin_balance.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_service.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_airtime.dart';

import 'bloc.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final GetHuluCoinBalance getHuluCoinBalance;
  final GetService getService;
  final PostAirtime postAirtime;

  CoinBloc(
      {required this.getHuluCoinBalance,
      required this.getService,
      required this.postAirtime})
      : super(CoinInitial()) {
    on<CoinEvent>(mapCoinState);
  }

  Future<void> mapCoinState(
    CoinEvent event,
    Emitter<CoinState> emit,
  ) async {
    if (event is GetCoinBalance) {
      print('LogHulu HistoryFirst: Add Request started');
      emit(LoadingCoinBalance());

      final failureOrSuccess = await getHuluCoinBalance(null);
      await failureOrSuccess.fold(
        (failure) async {
          print('LogHulu Response HuluCoin Balance error');
          emit(ErrorCoinBalance(
            message: _mapFailureToMessage(failure),
          ));
        },
        (success) async {
          print('LogHulu Response HuluCoin Balance received');

          final failureOrSuccessService = await getService(null);
          emit(failureOrSuccessService.fold(
            (failureService) {
              print('LogHulu Response HuluCoin Service error: $failureService');
              return LoadedCoinBalance(currentBalance: success, service: null);
            },
            (successService) {
              print('LogHulu Response Service received: $successService');
              Service? service;
              try {
                service = getServiceAirtime(successService);
              } catch (e) {
                print("LogHulu Service Error: $e");
              }

              return LoadedCoinBalance(
                  currentBalance: success, service: service);
            },
          ));
        },
      );
    } else if (event is GetCoinBuyAirtime) {
      print('LogHulu Airtime: Add Request started');
      emit(LoadingCoinBuyAirtime(
          currentBalance: event.currentBalance, service: event.service));

      final failureOrSuccess = await postAirtime(
          ParamsAirTime(service: event.service, amount: event.amount));
      emit(
        failureOrSuccess.fold(
          (failure) {
            print('LogHulu Response Airtime error: $failure');
            return ErrorCoinBuyAirtime(
                message: _mapFailureToMessage(failure),
                currentBalance: event.currentBalance,
                service: event.service);
          },
          (success) {
            print('LogHulu Response Airtime received: $success');
            return LoadedCoinBuyAirtime(
              service: event.service,
              airtimeSuccess: success,
            );
          },
        ),
      );
    }
  }

  Service? getServiceAirtime(dynamic serviceData) {
    bool isBreak = false;
    bool hasAvailableField = false;

    if (serviceData != null) {
      int idService = -1;
      int idPaymentProvider = -1;

      List<dynamic> jsonArrayResults = serviceData['results'];

      for (int i = 0; i < jsonArrayResults.length; i++) {
        dynamic jsonResultFields = jsonArrayResults.elementAt(i);
        if (jsonResultFields["value"].toString() == "air_time_top_up") {
          hasAvailableField = false;
          bool isAvailable = false;
          try {
            isAvailable = jsonResultFields["available"].toString() == 'true';
            hasAvailableField = true;
          } catch (e) {
            print('LogHulu Service data: $e');
          }

          try {
            idService = int.parse(jsonResultFields["id"].toString());
          } catch (e) {
            print('LogHulu Service data id: $e');
          }

          if (hasAvailableField) {
            if (isAvailable) {
              List<dynamic> jsonArrayPayment =
                  jsonResultFields['payment_providers'];

              for (int j = 0; j < jsonArrayPayment.length; j++) {
                dynamic jsonPaymentFields = jsonArrayPayment.elementAt(j);
                if (jsonPaymentFields["value"] == "hulucoin") {
                  try {
                    idPaymentProvider =
                        int.parse(jsonPaymentFields["id"].toString());
                    isBreak = true;
                    break;
                  } catch (e) {
                    print('LogHulu Service data payment id: $e');
                  }
                }
              }
            }
          } else {
            List<dynamic> jsonArrayPayment =
                jsonResultFields['payment_providers'];

            for (int j = 0; j < jsonArrayPayment.length; j++) {
              dynamic jsonPaymentFields = jsonArrayPayment.elementAt(j);
              if (jsonPaymentFields["value"] == "hulucoin") {
                try {
                  idPaymentProvider =
                      int.parse(jsonPaymentFields["id"].toString());
                  isBreak = true;
                  break;
                } catch (e) {
                  print('LogHulu Service data payment id: $e');
                }
              }
            }
          }
          if (isBreak) break;
        }
      }

      if (isBreak) {
        return Service(service: idService, paymentProvider: idPaymentProvider);
      } else {
        return null;
      }
    }
    return null;
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
