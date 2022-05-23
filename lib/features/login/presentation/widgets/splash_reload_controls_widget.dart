import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class SplashReloadControlsWidget extends StatefulWidget {
  String errMsg;
  SplashReloadControlsWidget({
    Key? key, required this.errMsg
  }) : super(key: key);

  @override
  _SplashReloadControlsWidgetState createState() =>
      _SplashReloadControlsWidgetState();
}

class _SplashReloadControlsWidgetState
    extends State<SplashReloadControlsWidget> {
  _SplashReloadControlsWidgetState() {
    // Future.delayed(const Duration(microseconds: 1500), () {
    //   print('LogHulu check reload: ${widget.errMsg}');
    //   addConfig();
    // });
  }

  @override
  Widget build(BuildContext context) {
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

  // void addConfig() {
  //   BlocProvider.of<SplashBloc>(context).add(GetSplash());
  // }
}
