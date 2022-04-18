import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/bloc.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  _SplashWidgetState() {
    Future.delayed(const Duration(microseconds: 100), () {
      addConfig();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height * 0.35,
            width: 124,
            child: Image.asset('assets/images/loader_icon.png'),
          ),
          const SizedBox(
            height: 64,
          ),
          const SizedBox(
            height: 36,
            child: SpinKitFadingCircle(
              color: Colors.green,
              size: 36.0,
            ),
          ),
        ],
      ),
    );
  }

  void addConfig() {
    BlocProvider.of<SplashBloc>(context).add(GetSplash());
  }
}
