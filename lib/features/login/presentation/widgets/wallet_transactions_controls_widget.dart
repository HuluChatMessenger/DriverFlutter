import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transaction_item.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class WalletTransactionsControlsWidget extends StatefulWidget {
  final WalletTransactions walletTransactions;

  WalletTransactionsControlsWidget({
    Key? key,
    required this.walletTransactions,
  }) : super(key: key);

  @override
  _WalletTransactionsControlsWidgetState createState() =>
      _WalletTransactionsControlsWidgetState();
}

class _WalletTransactionsControlsWidgetState
    extends State<WalletTransactionsControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            String? next = getNext();
            if (next != null) {
              addWalletTransactionsNext(next);
            }
          }
          return true;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: walletRows(context)),
        ),
      ),
    );
  }

  List<Widget> walletRows(BuildContext context) {
    var walletRows = <Widget>[];
    if (widget.walletTransactions.results != null) {
      for (WalletTransactionItem transaction
          in widget.walletTransactions.results) {
        Widget walletRow = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Text(
                CommonUtils.checkTime(
                    transaction.createdAt.split("T")[1].substring(0, 5)),
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                transaction.reasonText,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
              const Spacer(),
              Text(
                CommonUtils.formatCurrency(transaction.amount) +
                    " " +
                    'strBirr'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: <Widget>[
              Text(
                CommonUtils.checkMode(
                    transaction.createdAt.split("T")[1].substring(0, 2)),
                style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                transaction.createdAt.split("T")[0],
                style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
              ),
            ]),
            const SizedBox(height: 32),
          ],
        );

        walletRows.add(walletRow);
      }
    }

    return walletRows;
  }

  String? getNext() {
    String? nextString = widget.walletTransactions.next;
    String? next = nextString.split("page=").elementAt(1);
    print(
        "LogHulu Pagination Wallet Next: $next \\\ ====\\\\ ${widget.walletTransactions} === result");
    return next;
  }

  void addWalletTransactionsNext(String next) {
    print(
        "LogHulu Pagination Final: $next ==== $widget.walletTransactions === result");
    BlocProvider.of<WalletBloc>(context)
        .add(GetWallet(next, widget.walletTransactions));
  }
}
