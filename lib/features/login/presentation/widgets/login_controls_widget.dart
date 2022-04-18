import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
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
            labelText: AppConstants.strPromptPhone,
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
              errorValue = AppConstants.errMsgPhoneEmpty;
            } else if (InputConverter().stringValidPhone(inputStr!).isLeft()) {
              InputConverter().stringValidPhone(inputStr!).fold((l) {
                isValid = false;
                switch (l.runtimeType) {
                  case InvalidInputPhoneFailure:
                    errorValue = AppConstants.errMsgPhone;
                    break;
                  case InvalidInputIncompletePhoneFailure:
                    errorValue = null;
                    break;
                  case InvalidInputEmptyPhoneFailure:
                    errorValue = AppConstants.errMsgPhoneEmpty;
                }
              }, (r) => {isValid = true});
            } else {
              isValid = true;
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 40),
        MaterialButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                isValid &&
                inputStr != null) {
              addLogin(inputStr!);
            } else {
              return;
            }
          },
          child: Container(
            height: 50,
            color: Colors.green,
            child: Row(
              children: const [
                Text(
                  AppConstants.strContinue,
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          color: Colors.green,
          disabledColor: Colors.grey.shade300,
          textColor: Colors.white,
          disabledTextColor: Colors.grey,
          minWidth: MediaQuery.of(context).size.width - 100,
          height: 44,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ]),
    ) // )
        ;
  }

  void addLogin(String input) {
    FocusManager.instance.primaryFocus?.unfocus();
    BlocProvider.of<LoginBloc>(context).add(GetOTPForLogin(input));
  }
}
