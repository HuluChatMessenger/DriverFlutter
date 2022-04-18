import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

class DialogWidget extends StatelessWidget {
  final String? message;
  final String typeDialog;
  bool isDismiss = false;

  DialogWidget({
    Key? key,
    this.message,
    required this.typeDialog,
    required this.isDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (typeDialog == AppConstants.dialogTypeLoading) {
      Future.delayed(Duration.zero, () => showDialogLoading(context));
    } else if (typeDialog == AppConstants.dialogTypeErr && message == null) {
      Future.delayed(Duration.zero, () => showDialogMsgErrCommon(context));
    } else if (typeDialog == AppConstants.dialogTypeErr && message != null) {
      Future.delayed(Duration.zero, () => showDialogMsgErr(context, message!));
    } else if (typeDialog == AppConstants.dialogTypeMsg && message != null) {
      Future.delayed(Duration.zero, () => showDialogMsg(context, message!));
    }

    return Container();
  }

  void showDialogLoading(BuildContext context) {
    showDialog<bool>(
      barrierDismissible: isDismiss,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * 0.35,
                  child: const SpinKitFadingCircle(
                    color: Colors.green,
                    size: 36.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogMsgErrCommon(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: isDismiss,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            AppConstants.errMsgUnknown,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogMsgErr(BuildContext context, String messageDialog) {
    showDialog<bool>(
      context: context,
      barrierDismissible: isDismiss,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            messageDialog,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogMsg(BuildContext context, String messageDialog) {
    showDialog<bool>(
      context: context,
      barrierDismissible: isDismiss,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            messageDialog,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
