import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';

class ButtonWidget extends StatefulWidget {
  bool isBtnEnabled;
  Function btnFunction;
  String? btnText = 'strContinue'.tr;

  ButtonWidget({
    Key? key,
    required this.isBtnEnabled,
    required this.btnFunction,
    this.btnText,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() {
    return _ButtonWidgetState(
        isBtnEnabled: isBtnEnabled,
        btnFunction: btnFunction,
        btnText: (btnText != null) ? btnText! : 'strContinue'.tr);
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isBtnEnabled;
  Function btnFunction;
  var colorsBtnBack = Colors.grey.shade300;
  Color colorsBtnTxt = Colors.grey;
  String btnText = 'strContinue'.tr;

  _ButtonWidgetState(
      {required this.isBtnEnabled,
      required this.btnFunction,
      required this.btnText}) {
    bool isEnabled = isBtnEnabled;
    print("LogHulu Btn: $isEnabled === $isBtnEnabled");
    Future.delayed(const Duration(microseconds: 10), () {
      setState(() {
        print("LogHulu CheckBtn: $isEnabled === $isBtnEnabled");
        colorsBtnBack = isEnabled ? Colors.green : Colors.grey.shade300;
        colorsBtnTxt = isEnabled ? Colors.white : Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isBtnEnabled ? onBtnClicked : null,
      child: Container(
        height: 50,
        color: colorsBtnBack,
        child: Row(
          children: [
            Text(
              btnText,
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
    );
  }

  void onBtnClicked() {
    btnFunction();
  }
}
