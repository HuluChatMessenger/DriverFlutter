import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
      ),
      child: Center(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 72, right: 72, top: 324, bottom: 324),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: const SpinKitFadingCircle(
                color: Colors.green,
                size: 50.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
