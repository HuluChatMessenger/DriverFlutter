import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class ProfileLogoutControlsWidget extends StatefulWidget {
  const ProfileLogoutControlsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileLogoutControlsWidgetState createState() =>
      _ProfileLogoutControlsWidgetState();
}

class _ProfileLogoutControlsWidgetState
    extends State<ProfileLogoutControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialogLogout(context);
        },
        icon: const Icon(
          Icons.logout,
          color: Colors.white,
        ));
  }

  void showDialogLogout(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('strLogout'.tr),
          content: Text(
            'msgLogout'.tr,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'strLogout'.tr,
                style: const TextStyle(color: Colors.red),
              ),
              onPressed: () => addLogout(),
            ),
            TextButton(
              child: Text(
                'strCancel'.tr,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void addLogout() {
    BlocProvider.of<ProfileBloc>(context).add(const GetProfileLogout());
  }
}
