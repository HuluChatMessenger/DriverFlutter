import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../bloc/bloc.dart';

class OtpControlsWidget extends StatefulWidget {
  final String phoneNumber;
  final bool isRegistration;

  const OtpControlsWidget({
    Key? key,
    required this.phoneNumber,
    required this.isRegistration,
  }) : super(key: key);

  @override
  _OtpControlsWidgetState createState() => _OtpControlsWidgetState(
      phoneNumber: phoneNumber, isRegistration: isRegistration);
}

class _OtpControlsWidgetState extends State<OtpControlsWidget> {
  final String phoneNumber;
  String? inputStr;
  bool isValid = false;
  final bool isRegistration;

  _OtpControlsWidgetState(
      {required this.phoneNumber, required this.isRegistration});

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
            if(inputStr != null && inputStr!.length == 5) {
              addOtp(inputStr!);
            }
          },
          onChanged: (value) {
            print(value);
            setState(() {
              inputStr = value;
            });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
        const SizedBox(height: 64),
        Row(
          children: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  AppConstants.strResend,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )),
            const SizedBox(width: 4),
            Text(
              'in 0 seconds',
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
            const Spacer(),
            MaterialButton(
              onPressed: () {
                if (inputStr != null && inputStr!.length == 5) {
                  addOtp(inputStr!);
                } else {
                  return;
                }
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              color: Colors.green,
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

  void addOtp(String input) {
    FocusManager.instance.primaryFocus?.unfocus();
    final Otp otp = Otp(
      otp: input,
      phoneNumber: phoneNumber,
      isRegistration: isRegistration,
    );

    BlocProvider.of<OtpBloc>(context).add(GetOTP(otp));
  }
}
