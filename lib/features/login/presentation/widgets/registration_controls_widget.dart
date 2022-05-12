import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/registration_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/registration_event.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/terms_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/widgets/qr_controls_widget.dart';

import '../../../../core/util/input_converter.dart';

class RegistrationControlsWidget extends StatefulWidget {
  final bool isReferral;
  final Configuration configuration;
  Registration? registration;

  RegistrationControlsWidget({
    Key? key,
    required this.isReferral,
    this.registration,
    required this.configuration,
  }) : super(key: key);

  @override
  _RegistrationControlsWidgetState createState() =>
      _RegistrationControlsWidgetState(
        isReferral: isReferral,
        registration: registration,
        configuration: configuration,
      );
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

  Registration? registration;
  final Configuration configuration;

  var colorsBtnBack = Colors.grey.shade300;
  Color colorsBtnTxt = Colors.grey;
  final controllerReferral = TextEditingController();
  final controllerNameFirst = TextEditingController();
  final controllerNameMiddle = TextEditingController();
  final controllerNameLast = TextEditingController();
  final controllerPhone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _RegistrationControlsWidgetState({
    required this.isReferral,
    this.registration,
    required this.configuration,
  }) {
    if (registration != null) {
      controllerNameFirst.text = registration!.firstName;
      controllerNameMiddle.text = registration!.fatherName;
      controllerNameLast.text = registration!.grandfatherName;
      controllerPhone.text = registration!.phoneNumber;
      if (registration?.isTerms != null) {
        isTerms = registration!.isTerms == true;
      }
      if (isReferral &&
          registration!.referralCode != null &&
          registration!.referralCode?.isNotEmpty == true) {
        controllerReferral.text = registration!.referralCode!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          controller: controllerNameFirst,
          keyboardType: TextInputType.name,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppConstants.strPromptFirstName,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          onChanged: (value) {
            inputStrFirstName = value;
            setBtnEnabled();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrFirstName == null ||
                (inputStrFirstName != null && inputStrFirstName!.isEmpty)) {
              errorValue = AppConstants.errMsgEmptyFirst;
            } else {
              errorValue = null;
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controllerNameMiddle,
          keyboardType: TextInputType.name,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppConstants.strPromptFatherName,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          onChanged: (value) {
            inputStrFatherName = value;
            setBtnEnabled();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrFatherName == null ||
                (inputStrFatherName != null && inputStrFatherName!.isEmpty)) {
              errorValue = AppConstants.errMsgEmptyFather;
            } else {
              errorValue = null;
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controllerNameLast,
          keyboardType: TextInputType.name,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppConstants.strPromptGFatherName,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          onChanged: (value) {
            inputStrGrandFatherName = value;
            setBtnEnabled();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrGrandFatherName == null ||
                (inputStrGrandFatherName != null &&
                    inputStrGrandFatherName!.isEmpty)) {
              errorValue = AppConstants.errMsgEmptyGrandfather;
            } else {
              errorValue = null;
            }
            return errorValue;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controllerPhone,
          keyboardType: TextInputType.phone,
          inputFormatters: [LengthLimitingTextInputFormatter(9)],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: AppConstants.strPromptPhone,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefix: SizedBox(
              width: 76,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset('assets/images/et.svg',
                        semanticsLabel: 'Country Flag'),
                  ),
                  const SizedBox(width: 4),
                  const Text('+251')
                ],
              ),
            ),
          ),
          onChanged: (value) {
            inputStrPhone = value;
            setBtnEnabled();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String? errorValue;
            if (inputStrPhone == null) {
              errorValue = AppConstants.errMsgEmptyPhone;
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
                    errorValue = AppConstants.errMsgEmptyPhone;
                }
              }, (r) => {});
            } else {
              errorValue = null;
            }
            return errorValue;
          },
        ),
        referralFieldSpacing(),
        referralField(configuration),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Checkbox(
                activeColor: Colors.green,
                value: isTerms,
                onChanged: (value) {
                  setState(() {
                    isTerms = value == true;
                    isErrVisible = !isTerms;
                  });
                  setBtnEnabled();
                }),
            TextButton(
              child: const Text(AppConstants.strAgree,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  )),
              onPressed: () {
                setState(() {
                  isTerms = !isTerms;
                  isErrVisible = !isTerms;
                });
                setBtnEnabled();
              },
            ),
            TextButton(
              child: const Text(AppConstants.strTerms,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                  )),
              onPressed: () {
                openTerms();
              },
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
        MaterialButton(
          onPressed: isBtnEnabled ? onBtnClicked : null,
          child: Container(
            height: 50,
            color: colorsBtnBack,
            child: Row(
              children: [
                Text(
                  AppConstants.strContinue,
                  style: TextStyle(fontSize: 20, color: colorsBtnTxt),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward,
                  color: colorsBtnTxt,
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
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ]),
    ) // )
        ;
  }

  void qrScanner(Configuration configuration) {
    String firstName = (inputStrFirstName != null) ? inputStrFirstName! : '';
    String fatherName = (inputStrFatherName != null) ? inputStrFatherName! : '';
    String grandfatherName =
        (inputStrGrandFatherName != null) ? inputStrGrandFatherName! : '';
    String phoneNumber = (inputStrPhone != null) ? inputStrPhone! : '';

    final registrationCurrent = Registration(
        id: 0,
        firstName: firstName,
        fatherName: fatherName,
        grandfatherName: grandfatherName,
        phoneNumber: phoneNumber,
        referralCode: inputStrReferral,
        isTerms: isTerms);

    Get.to(() => QRControlsWidget(
          registration: registrationCurrent,
          contextBloc: context,
          configuration: configuration,
        ));
  }

  void onBtnClicked() {
    addRegistration(inputStrFirstName!, inputStrFatherName!,
        inputStrGrandFatherName!, inputStrPhone!, inputStrReferral);
    ;
  }

  void setBtnEnabled() {
    setState(() {
      if ((_formKey.currentState != null &&
              _formKey.currentState!.validate()) &&
          inputStrFirstName != null &&
          inputStrFatherName != null &&
          inputStrGrandFatherName != null &&
          (inputStrPhone != null && inputStrPhone?.length == 9) &&
          isTerms) {
        isBtnEnabled = true;
        colorsBtnBack = Colors.green;
        colorsBtnTxt = Colors.white;
      } else {
        isBtnEnabled = false;
        colorsBtnBack = Colors.grey.shade300;
        colorsBtnTxt = Colors.grey;
        if (!isTerms) {
          isErrVisible = true;
        }
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

  Widget referralField(Configuration configuration) {
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
                  qrScanner(configuration);
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

  void openTerms() {
    Get.to(() => const TermsPage());
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
        referralCode: referralCode,
        isTerms: isTerms);

    BlocProvider.of<RegistrationBloc>(context)
        .add(GetOTPForRegistration(registration));
  }
}
