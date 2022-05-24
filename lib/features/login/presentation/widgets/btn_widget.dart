import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return _ButtonWidgetState();
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.isBtnEnabled ? onBtnClicked : null,
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
        color: widget.isBtnEnabled ?  Colors.green :  Colors.grey.shade300,
        child: Row(
          children: [
            Text(
              widget.btnText != null ? widget.btnText! : 'strContinue'.tr,
              style: TextStyle(fontSize: 20, color: widget.isBtnEnabled ?  Colors.white :  Colors.grey),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              color: widget.isBtnEnabled ?  Colors.white :  Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void onBtnClicked() {
    widget.btnFunction();
  }
}
