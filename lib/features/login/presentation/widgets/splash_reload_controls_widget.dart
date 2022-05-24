import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class SplashReloadControlsWidget extends StatefulWidget {
  String errMsg;
  dynamic connectionStateStream;

  SplashReloadControlsWidget(
      {Key? key, required this.errMsg, required this.connectionStateStream})
      : super(key: key);

  @override
  _SplashReloadControlsWidgetState createState() =>
      _SplashReloadControlsWidgetState();
}

class _SplashReloadControlsWidgetState
    extends State<SplashReloadControlsWidget> {
  _SplashReloadControlsWidgetState() {
    if (widget.connectionStateStream.connectionStatus != null) {
      try {
        Stream<DataConnectionStatus> value =
            widget.connectionStateStream.connectionStatus!;
        value.listen((connectionState) {
          if (DataConnectionStatus.connected == connectionState) {
            addConfig();
          }
        });
      } catch (e) {
        print('LogHulu Connection: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return showErrorMsg();
  }

  Widget showErrorMsg() {
    return Positioned(
      bottom: 32,
      right: 16,
      left: 16,
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 14,
            color: Colors.green,
            fontStyle: FontStyle.italic,
          ),
          child: Text(widget.errMsg),
        ),
      ),
    );
  }

  void addConfig() {
    BlocProvider.of<SplashBloc>(context).add(GetSplash());
  }
}
