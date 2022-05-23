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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            Image.asset(
              'assets/images/loader_icon.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 36,
              child: SpinKitFadingCircle(
                color: Colors.green,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
