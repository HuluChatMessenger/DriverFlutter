import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  static const platform = const MethodChannel('flutter.native/helper');

  // Get battery level.
  String _responseFromNativeCode = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String response = "";
    try {
      final String result = await  platform.invokeMethod('helloFromNativeCode');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }

    setState(() {
      _responseFromNativeCode = response;
    });
  }

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
            // ElevatedButton(
            //   child: const Text('Get Battery Level'),
            //   onPressed: _getBatteryLevel,
            // ),
            // Text(
            //   _responseFromNativeCode,
            //   style: TextStyle(color: Colors.red, fontSize: 14),
            // )
          ],
        ),
      ),
    );
  }
}
