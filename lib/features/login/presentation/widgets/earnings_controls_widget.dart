import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class EarningsControlsWidget extends StatefulWidget {
  final bool isFirst;

  const EarningsControlsWidget(
      {Key? key,
      required this.isFirst,})
      : super(key: key);

  @override
  _EarningsControlsWidgetState createState() =>
      _EarningsControlsWidgetState(isFirst: isFirst);
}

class _EarningsControlsWidgetState extends State<EarningsControlsWidget> {
  final bool isFirst;

  _EarningsControlsWidgetState(
      {required this.isFirst}) {
    if (isFirst) {
      Future.delayed(const Duration(microseconds: 15), () {
        addEarnings();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void addEarnings() {
    BlocProvider.of<EarningsBloc>(context).add(GetEarningsFirst());
  }
}
