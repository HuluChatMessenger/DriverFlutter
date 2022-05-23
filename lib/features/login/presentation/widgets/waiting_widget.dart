import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class WaitingWidget extends StatefulWidget {
  WaitingWidget({
    Key? key,
  }) : super(key: key);

  @override
  _WaitingWidgetState createState() => _WaitingWidgetState();
}

class _WaitingWidgetState extends State<WaitingWidget> {
  @override
  Widget build(BuildContext context) {
    return startWaitingCall(context);
  }

  Widget startWaitingCall(BuildContext context) {
    Future.delayed(const Duration(seconds: 60), () {
      BlocProvider.of<WaitingBloc>(context).add(const GetWaiting());
    });
    return Container();
  }
}
