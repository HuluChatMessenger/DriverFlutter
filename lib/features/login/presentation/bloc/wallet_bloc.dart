import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transaction_item.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_wallet_initial.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_wallet_next.dart';

import 'bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletInitial getWalletInitial;
  final GetWalletNext getWalletNext;

  WalletBloc({required this.getWalletInitial, required this.getWalletNext})
      : super(WalletInitial()) {
    on<WalletEvent>(mapWalletState);
  }

  Future<void> mapWalletState(
    WalletEvent event,
    Emitter<WalletState> emit,
  ) async {
    if (event is GetWalletFirst) {
      print('LogHulu WalletFirst: Add Request started');
      emit(LoadingWallet());

      final failureOrSuccess = await getWalletInitial(null);
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response error');
          return ErrorWallet(
            message: _mapFailureToMessage(failure),
          );
        },
        (success) {
          print('LogHulu Response received');
          return LoadedWallet(walletTransactions: success);
        },
      ));
    } else if (event is GetWallet) {
      print('LogHulu WalletNext: Add Request started');
      emit(LoadingWalletNext(walletTransactions: event.walletTransactions));

      final failureOrSuccess =
          await getWalletNext(ParamsWalletNext(next: event.nextUrl));
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response wallet error: $failure');
          return ErrorWalletNext(
              message: _mapFailureToMessage(failure),
              walletTransactions: event.walletTransactions);
        },
        (success) {
          print('LogHulu Response wallet received: $success');
          List<WalletTransactionItem> results =
              event.walletTransactions.results;
          results.addAll(success.results);
          WalletTransactions updatedTransactions = WalletTransactions(
              count: success.count, next: success.next, results: results);
          return LoadedWalletNext(walletTransactions: updatedTransactions);
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
