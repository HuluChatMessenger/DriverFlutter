import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/feedbacks.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class FeedbackControlsWidget extends StatefulWidget {
  final Configuration configuration;

  FeedbackControlsWidget({
    Key? key,
    required this.configuration,
  }) : super(key: key);

  @override
  _FeedbackControlsWidgetState createState() => _FeedbackControlsWidgetState(
        configuration: configuration,
      );
}

class _FeedbackControlsWidgetState extends State<FeedbackControlsWidget> {
  final Configuration configuration;
  String? inputFeedbackType;
  String? inputUrgencyLevel;
  String? inputFeedback;
  bool isErrVisibleFeedbackType = false;
  bool isErrVisibleUrgencyLevel = false;
  bool isBtnEnabled = false;
  var colorsBtnBack = Colors.grey.shade300;
  Color colorsBtnTxt = Colors.grey;

  final _formKey = GlobalKey<FormState>();

  _FeedbackControlsWidgetState({
    required this.configuration,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          DropdownButton<String>(
            hint: Text('strFeedbackType'.tr),
            isExpanded: true,
            items: configuration.feedbackTypes.map((List<String> value) {
              String valueFeedBackType = '';
              if (value.length > 0) {
                valueFeedBackType = value.elementAt(1);
              }
              return DropdownMenuItem<String>(
                value: valueFeedBackType,
                child: Text(valueFeedBackType),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  inputFeedbackType = value;
                }
              });
              setBtnEnabled();
            },
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: isErrVisibleFeedbackType,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: Row(
                children:  [
                  Text('errMsgFeedbackType'.tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ),
          DropdownButton<String>(
            hint: Text('strUrgencyLevel'.tr),
            isExpanded: true,
            items:
                configuration.feedbackUrgencyLevels.map((List<String> value) {
              String valueUrgencyLevel = '';
              if (value.length > 0) {
                valueUrgencyLevel = value.elementAt(1);
              }
              return DropdownMenuItem<String>(
                value: valueUrgencyLevel,
                child: Text(valueUrgencyLevel),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  inputUrgencyLevel = value;
                }
              });
              setBtnEnabled();
            },
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: isErrVisibleUrgencyLevel,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: Row(
                children: [
                  Text('errMsgUrgencyLeve'.tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            minLines: 10,
            maxLines: 10,
            inputFormatters: [LengthLimitingTextInputFormatter(13)],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'strPromptFeedback'.tr,
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            onChanged: (value) {
              inputFeedback = value;
              setBtnEnabled();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              String? errorValue;
              if (inputFeedback == null || inputFeedback?.isEmpty == true) {
                errorValue = 'errMsgEmptyFeedback'.tr;
              }
              return errorValue;
            },
          ),
          const SizedBox(height: 64),
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
                    'strSend'.tr,
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
      ),
    ) // )
        ;
  }

  void setBtnEnabled() {
    setState(() {
      isErrVisibleFeedbackType =
          !(inputFeedback != null || inputFeedback?.isNotEmpty == true);
      isErrVisibleUrgencyLevel =
          !(inputUrgencyLevel != null || inputUrgencyLevel?.isNotEmpty == true);

      if ((_formKey.currentState != null &&
              _formKey.currentState!.validate()) &&
          (inputFeedback != null || inputFeedback?.isNotEmpty == true) &&
          (inputUrgencyLevel != null ||
              inputUrgencyLevel?.isNotEmpty == true) &&
          (inputFeedback != null || inputFeedback?.isNotEmpty == true)) {
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

  void onBtnClicked() {
    if (inputFeedbackType != null &&
        inputUrgencyLevel != null &&
        inputFeedback != null) {
      addFeedback(
        inputFeedbackType!,
        inputUrgencyLevel!,
        inputFeedback!,
      );
    }
  }

  void addFeedback(
    String feedbackType,
    String urgencyLevel,
    String feedback,
  ) {
    FocusManager.instance.primaryFocus?.unfocus();
    BlocProvider.of<FeedbackBloc>(context).add(
      GetFeedback(
        Feedbacks(
          feedbackType: feedbackType,
          urgencyLevel: urgencyLevel,
          feedback: feedback,
        ),
      ),
    );
  }
}
