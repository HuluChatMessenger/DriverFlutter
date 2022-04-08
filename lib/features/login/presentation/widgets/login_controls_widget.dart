import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';

import '../bloc/bloc.dart';

class LoginControlsWidget extends StatefulWidget {
  const LoginControlsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoginControlsWidgetState createState() => _LoginControlsWidgetState();
}

class _LoginControlsWidgetState extends State<LoginControlsWidget> {
  String? inputStr;
  bool isValid = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.phone,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Enter Phone Number',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefix: Container(
              width: 72,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset('assets/images/et.svg',
                        semanticsLabel: 'Top Curve'),
                  ),
                  const SizedBox(width: 4),
                  const Text('+251')
                ],
              ),
            ),
          ),
          onChanged: (value) {
            inputStr = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStr == null) {
              errorValue = 'Please enter a phone number!';
            } else if (InputConverter().stringValidPhone(inputStr!).isLeft()) {
              InputConverter().stringValidPhone(inputStr!).fold((l) {
                isValid = false;
                switch (l.runtimeType) {
                  case InvalidInputPhoneFailure:
                    errorValue = 'Phone number starts with the digit 9 or 7!';
                    break;
                  case InvalidInputIncompletePhoneFailure:
                    errorValue = null;
                    break;
                  case InvalidInputEmptyPhoneFailure:
                    errorValue = 'Please enter a phone number!';
                }
              }, (r) => {isValid = true});
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 40),
        // Button
        ElevatedButton(
            onPressed: () {
              if (isValid && inputStr != null) {
                addLogin(inputStr!);
              }
            },
            style: ElevatedButton.styleFrom(primary: Colors.grey.shade300),
            child: Container(
              height: 50,
              color: Colors.grey.shade300,
              child: Row(
                children: const [
                  Text(
                    'Continue',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  ),
                ],
              ),
            )),
      ]),
    ) // )
        ;
  }

  void addLogin(String input) {
    BlocProvider.of<LoginBloc>(context).add(GetOTPForLogin(input));
  }
}
