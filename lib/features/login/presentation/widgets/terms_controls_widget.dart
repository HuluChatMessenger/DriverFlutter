import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widgets.dart';

class TermsControlsWidget extends StatefulWidget {
  const TermsControlsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _TermsControlsWidgetState createState() => _TermsControlsWidgetState();
}

class _TermsControlsWidgetState extends State<TermsControlsWidget> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      WebView(
        initialUrl: AppConstants.urlTerms,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (finish) {
          setState(() {
            isLoading = false;
          });
        },
      ),
      isLoading ? const LoadingWidget() : Container(),
    ]);
  }
}
