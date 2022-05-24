import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/registration_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/registration_event.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/terms_page.dart';

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
      _RegistrationControlsWidgetState();
}

class _RegistrationControlsWidgetState
    extends State<RegistrationControlsWidget> {
  bool isErrVisible = false;
  bool isTerms = false;
  bool isBtnEnabled = false;
  String? inputStrFirstName;
  String? inputStrFatherName;
  String? inputStrGrandFatherName;
  String? inputStrPhone;
  String? inputStrReferral;

  var colorsBtnBack = Colors.grey.shade300;
  Color colorsBtnTxt = Colors.grey;
  final controllerReferral = TextEditingController();
  final controllerNameFirst = TextEditingController();
  final controllerNameMiddle = TextEditingController();
  final controllerNameLast = TextEditingController();
  final controllerPhone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _RegistrationControlsWidgetState() {
    Future.delayed(const Duration(microseconds: 5), () {
      if (widget.registration != null) {
        controllerNameFirst.text = widget.registration!.firstName;
        controllerNameMiddle.text = widget.registration!.fatherName;
        controllerNameLast.text = widget.registration!.grandfatherName;
        controllerPhone.text = widget.registration!.phoneNumber;
        if (widget.registration?.isTerms != null) {
          isTerms = widget.registration!.isTerms == true;
        }
        if (widget.isReferral &&
            widget.registration!.referralCode != null &&
            widget.registration!.referralCode?.isNotEmpty == true) {
          controllerReferral.text = widget.registration!.referralCode!;
        }
      }
    });
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
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'strPromptFirstName'.tr,
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
              errorValue = 'errMsgEmptyFirst'.tr;
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
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'strPromptFatherName'.tr,
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
              errorValue = 'errMsgEmptyFather'.tr;
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
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'strPromptGFatherName'.tr,
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
              errorValue = 'errMsgEmptyGrandfather'.tr;
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
            labelText: 'strPromptPhone'.tr,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefix: SizedBox(
              width: 76,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset('assets/images/icons.svg',
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
              errorValue = 'errMsgEmptyPhone'.tr;
            } else if (InputConverter()
                .stringValidPhone(inputStrPhone!)
                .isLeft()) {
              InputConverter().stringValidPhone(inputStrPhone!).fold((l) {
                switch (l.runtimeType) {
                  case InvalidInputPhoneFailure:
                    errorValue = 'errMsgPhone'.tr;
                    break;
                  case InvalidInputIncompletePhoneFailure:
                    errorValue = null;
                    break;
                  case InvalidInputEmptyPhoneFailure:
                    errorValue = 'errMsgEmptyPhone'.tr;
                }
              }, (r) => {});
            } else {
              errorValue = null;
            }
            return errorValue;
          },
        ),
        referralFieldSpacing(),
        referralField(widget.configuration),
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
              child: Text('strAgree'.tr,
                  style: const TextStyle(
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
              child: Text('strTerms'.tr,
                  style: const TextStyle(
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
              children: [
                Text('errTerms'.tr,
                    style: const TextStyle(
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
          color: Colors.green,
          disabledColor: Colors.grey.shade300,
          textColor: Colors.white,
          disabledTextColor: Colors.grey,
          minWidth: MediaQuery.of(context).size.width - 100,
          height: 44,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 50,
            color: colorsBtnBack,
            child: Row(
              children: [
                Text(
                  'strContinue'.tr,
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

    // Get.to(() => QRControlsWidget(
    //       registration: registrationCurrent,
    //       contextBloc: context,
    //       configuration: configuration,
    //     ));
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
    if (widget.isReferral) {
      return const SizedBox(height: 16);
    } else {
      return Container();
    }
  }

  Widget referralField(Configuration configuration) {
    if (widget.isReferral) {
      return TextFormField(
        keyboardType: TextInputType.text,
        inputFormatters: [LengthLimitingTextInputFormatter(9)],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'strPromptReferralCode'.tr,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffix: SizedBox(
            width: 36,
            height: 20,
            child: IconButton(
                onPressed: () {
                  qrScanner(configuration);
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                  size: 28,
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
