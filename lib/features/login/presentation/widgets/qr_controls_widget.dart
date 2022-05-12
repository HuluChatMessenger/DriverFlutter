import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/registration_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../bloc/bloc.dart';

class QRControlsWidget extends StatefulWidget {
  Registration registration;
  BuildContext contextBloc;
  final Configuration configuration;

  QRControlsWidget(
      {Key? key,
      required this.registration,
      required this.contextBloc,
      required this.configuration})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRControlsWidgetState(
        registration: registration,
        contextBloc: contextBloc,
        configuration: configuration,
      );
}

class _QRControlsWidgetState extends State<QRControlsWidget> {
  Registration registration;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  BuildContext contextBloc;
  final Configuration configuration;

  _QRControlsWidgetState(
      {required this.registration,
      required this.contextBloc,
      required this.configuration});

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null && scanData.code != null) {
        addRegistration(scanData.code.toString());
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void addRegistration(String resultCode) {
    print('LogHulu QR: $resultCode');
    final registrationResult = registration;
    registrationResult.referralCode = resultCode;
    BlocProvider.of<RegistrationBloc>(contextBloc)
        .add(GetOTPForRegistration(registrationResult));
    Get.offAll(() => RegistrationPage(
          isReferral: true,
          registrationSaved: registrationResult,
          isQR: true,
          configuration: configuration,
        ));
  }
}
