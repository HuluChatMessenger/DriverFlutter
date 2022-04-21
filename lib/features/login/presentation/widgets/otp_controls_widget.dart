import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../bloc/bloc.dart';

class OtpControlsWidget extends StatefulWidget {
  final String phoneNumber;
  Registration? registration;
  final bool isRegistration;

  OtpControlsWidget({
    Key? key,
    required this.phoneNumber,
    this.registration,
    required this.isRegistration,
  }) : super(key: key);

  @override
  _OtpControlsWidgetState createState() => _OtpControlsWidgetState(
      phoneNumber: phoneNumber,
      registration: registration,
      isRegistration: isRegistration);
}

class _OtpControlsWidgetState extends State<OtpControlsWidget> {
  Registration? registration;
  final String phoneNumber;
  String? inputStr;
  final bool isRegistration;
  bool isBtnEnabled = false;
  bool isResendCode = false;
  String resendCodeTimer = AppConstants.strResend;
  var colorsBtnBack = Colors.grey.shade300;
  MaterialColor colorsResend = Colors.grey;
  Color colorsBtnTxt = Colors.grey;
  int _start = 60;

  _OtpControlsWidgetState(
      {required this.phoneNumber, this.registration,
      required this.isRegistration}) {
    startTimer();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        PinCodeTextField(
          appContext: context,
          length: 5,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.green.shade50,
            inactiveColor: Colors.green.shade50,
            inactiveFillColor: Colors.green.shade50,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          onCompleted: (v) {
            if (isBtnEnabled && inputStr != null && inputStr!.length == 5) {
              addOtp(inputStr!);
            }
          },
          onChanged: (value) {
            print(value);
            setState(() {
              inputStr = value;
            });
            setBtnEnabled();
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            return true;
          },
        ),
        const SizedBox(height: 64),
        Row(
          children: [
            TextButton(
                onPressed: (isResendCode) ? onBtnResendClicked : null,
                child: Text(
                  AppConstants.strResend,
                  style: TextStyle(fontSize: 14, color: colorsResend),
                )),
            const SizedBox(width: 4),
            Text(
              resendCodeTimer,
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
            const Spacer(),
            MaterialButton(
              onPressed: (isBtnEnabled) ? onBtnClicked : null,
              child: Icon(
                Icons.arrow_forward,
                color: colorsBtnTxt,
              ),
              color: colorsBtnBack,
              disabledColor: Colors.grey.shade300,
              textColor: Colors.white,
              disabledTextColor: Colors.grey,
              minWidth: 48,
              height: 54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ],
        ),
      ]),
    ) // )
        ;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _start = 60;
    colorsResend = Colors.grey;
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isResendCode = true;
            resendCodeTimer = '';
            colorsResend = Colors.green;
          });
        } else {
          setState(() {
            _start--;
            resendCodeTimer = 'in $_start seconds';
          });
        }
      },
    );
  }

  void onBtnClicked() {
    if (inputStr != null) addOtp(inputStr!);
  }

  void onBtnResendClicked() {
    startTimer();
    addResendOtp();
  }

  void setBtnEnabled() {
    setState(() {
      if (inputStr != null && inputStr!.length == 5) {
        isBtnEnabled = true;
        colorsBtnBack = Colors.green;
        colorsBtnTxt = Colors.white;
      } else {
        isBtnEnabled = false;
        colorsBtnBack = Colors.grey.shade300;
        colorsBtnTxt = Colors.grey;
      }
    });
  }

  void addOtp(String input) {
    FocusManager.instance.primaryFocus?.unfocus();
    final Otp otp = Otp(
      otp: input,
      phoneNumber: phoneNumber,
      isRegistration: isRegistration,
    );

    BlocProvider.of<OtpBloc>(context).add(GetOTP(otp));
  }

  void addResendOtp() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isRegistration && registration != null) {
      BlocProvider.of<OtpBloc>(context)
          .add(ResendOTPRegistration(registration!));
    } else if (!isRegistration) {
      BlocProvider.of<OtpBloc>(context).add(ResendOTPLogin(phoneNumber));
    }
  }
}
