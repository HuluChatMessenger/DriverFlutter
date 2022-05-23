import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class WalletControlsWidget extends StatefulWidget {
  final bool isFirst;

  const WalletControlsWidget(
      {Key? key,
      required this.isFirst,})
      : super(key: key);

  @override
  _WalletControlsWidgetState createState() =>
      _WalletControlsWidgetState(isFirst: isFirst);
}

class _WalletControlsWidgetState extends State<WalletControlsWidget> {
  final bool isFirst;

  _WalletControlsWidgetState(
      {required this.isFirst}) {
    if (isFirst) {
      Future.delayed(const Duration(microseconds: 15), () {
        addWalletTransactions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void addWalletTransactions() {
    BlocProvider.of<WalletBloc>(context).add(GetWalletFirst());
  }
}
