import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/registration_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/registration_event.dart';

import '../../../../core/util/input_converter.dart';

class RegistrationControlsWidget extends StatefulWidget {
  final bool isReferral;

  RegistrationControlsWidget({
    Key? key,
    required this.isReferral,
  }) : super(key: key);

  @override
  _RegistrationControlsWidgetState createState() =>
      _RegistrationControlsWidgetState(isReferral: isReferral);
}

class _RegistrationControlsWidgetState
    extends State<RegistrationControlsWidget> {
  bool isErrVisible = false;
  bool isTerms = false;
  bool isBtnEnabled = false;
  bool isReferral;
  String? inputStrFirstName;
  String? inputStrFatherName;
  String? inputStrGrandFatherName;
  String? inputStrPhone;
  String? inputStrReferral;
  final controllerReferral = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _RegistrationControlsWidgetState({required this.isReferral});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.name,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppConstants.strPromptFirstName,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          onChanged: (value) {
            inputStrFirstName = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrFirstName == null ||
                (inputStrFirstName != null && inputStrFirstName!.isEmpty)) {
              errorValue = AppConstants.errMsgFirstEmpty;
              isBtnEnabled = false;
            } else {
              errorValue = null;
              if (inputStrGrandFatherName != null &&
                  inputStrFatherName != null &&
                  isTerms &&
                  isBtnEnabled) {
                isBtnEnabled = true;
              }
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          keyboardType: TextInputType.name,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppConstants.strPromptFatherName,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          onChanged: (value) {
            inputStrFatherName = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrFatherName == null ||
                (inputStrFatherName != null && inputStrFatherName!.isEmpty)) {
              errorValue = AppConstants.errMsgFatherEmpty;
              isBtnEnabled = false;
            } else {
              errorValue = null;
              if (inputStrFirstName != null &&
                  inputStrGrandFatherName != null &&
                  isTerms &&
                  isBtnEnabled) {
                isBtnEnabled = true;
              }
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          keyboardType: TextInputType.name,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppConstants.strPromptGFatherName,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          onChanged: (value) {
            inputStrGrandFatherName = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrGrandFatherName == null ||
                (inputStrGrandFatherName != null &&
                    inputStrGrandFatherName!.isEmpty)) {
              errorValue = AppConstants.errMsgGrandfatherEmpty;
              isBtnEnabled = false;
            } else {
              errorValue = null;
              if (inputStrFirstName != null &&
                  inputStrFatherName != null &&
                  isTerms &&
                  isBtnEnabled) {
                isBtnEnabled = true;
              }
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          keyboardType: TextInputType.phone,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: AppConstants.strPromptPhone,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefix: SizedBox(
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
            inputStrPhone = value;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrPhone == null) {
              errorValue = AppConstants.errMsgPhoneEmpty;
            } else if (InputConverter()
                .stringValidPhone(inputStrPhone!)
                .isLeft()) {
              InputConverter().stringValidPhone(inputStrPhone!).fold((l) {
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
              }, (r) => {});
            } else {
              errorValue = null;
            }
            if (errorValue != null) {
              isBtnEnabled = false;
            } else if (inputStrFirstName != null &&
                inputStrFatherName != null &&
                inputStrGrandFatherName != null &&
                inputStrPhone != null &&
                isTerms &&
                isBtnEnabled) {
              isBtnEnabled = true;
            }
            return errorValue;
          },
        ),
        referralFieldSpacing(),
        referralField(),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.green,
                value: isTerms,
                onChanged: (value) {
                  setState(() {
                    isTerms = value == true;
                    isErrVisible = !isTerms;
                  });
                }),
            TextButton(
              child: const Text(AppConstants.strAgree,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  )),
              onPressed: () {
                setState(() {
                  isTerms = !isTerms;
                  isErrVisible = !isTerms;
                });
              },
            ),
            TextButton(
              child: const Text(AppConstants.strTerms,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  )),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 8),
        Visibility(
          visible: isErrVisible,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Row(
              children: const [
                Text(AppConstants.errTerms,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Button
        MaterialButton(
          onPressed: (isBtnEnabled) ? onButtonClicked : null,
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

  void qrScanner() {
    controllerReferral.text = "Scanner Result";
  }

  Function onButtonClicked() {
    return () {
      addRegistration(inputStrFirstName!, inputStrFatherName!,
          inputStrGrandFatherName!, inputStrPhone!, inputStrReferral);
    };
  }

  void setBtnEnabled() {
    setState(() {
      if (_formKey.currentState!.validate() &&
          inputStrFirstName != null &&
          inputStrFatherName != null &&
          inputStrGrandFatherName != null &&
          inputStrPhone != null &&
          isTerms) {
        isBtnEnabled = true;
      } else {
        isBtnEnabled = false;
      }
    });
  }

  Widget referralFieldSpacing() {
    if (isReferral) {
      return const SizedBox(height: 16);
    } else {
      return Container();
    }
  }

  Widget referralField() {
    if (isReferral) {
      return TextFormField(
        keyboardType: TextInputType.text,
        inputFormatters: [LengthLimitingTextInputFormatter(9)],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: AppConstants.strPromptReferralCode,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffix: SizedBox(
            width: 72,
            height: 20,
            child: IconButton(
                onPressed: () {
                  qrScanner();
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                  size: 24,
                  color: Colors.green,
                )),
          ),
        ),
        onChanged: (value) {
          inputStrReferral = value;
        },
        controller: controllerReferral,
      );
    } else {
      return Container();
    }
  }

  void addRegistration(String first, String father, String grandfather,
      String phone, String? referralCode) {
    FocusManager.instance.primaryFocus?.unfocus();
    final registration = Registration(
        id: 0,
        firstName: first,
        fatherName: father,
        grandfatherName: grandfather,
        phoneNumber: phone,
        referralCode: referralCode);

    BlocProvider.of<RegistrationBloc>(context)
        .add(GetOTPForRegistration(registration));
  }
}
