import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_hulu_coin_balance.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class HuluCoinControlsWidget extends StatefulWidget {
  final bool isFirst;

  const HuluCoinControlsWidget({
    Key? key,
    required this.isFirst,
  }) : super(key: key);

  @override
  _HuluCoinControlsWidgetState createState() =>
      _HuluCoinControlsWidgetState(isFirst: isFirst);
}

class _HuluCoinControlsWidgetState extends State<HuluCoinControlsWidget> {
  final bool isFirst;

  _HuluCoinControlsWidgetState({required this.isFirst}) {
    if (isFirst) {
      Future.delayed(const Duration(microseconds: 15), () {
        addHuluCoin();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void addHuluCoin() {
    BlocProvider.of<CoinBloc>(context).add(const GetCoinBalance());
  }
}
