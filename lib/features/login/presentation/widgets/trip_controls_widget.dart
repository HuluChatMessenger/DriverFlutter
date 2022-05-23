import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class TripControlsWidget extends StatefulWidget {
  final bool isFirst;

  const TripControlsWidget(
      {Key? key,
      required this.isFirst,})
      : super(key: key);

  @override
  _TripControlsWidgetState createState() =>
      _TripControlsWidgetState(isFirst: isFirst);
}

class _TripControlsWidgetState extends State<TripControlsWidget> {
  final bool isFirst;

  _TripControlsWidgetState(
      {required this.isFirst}) {
    if (isFirst) {
      Future.delayed(const Duration(microseconds: 15), () {
        addTrip();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void addTrip() {
    BlocProvider.of<HistoryBloc>(context).add(GetHistoryFirst());
  }
}
