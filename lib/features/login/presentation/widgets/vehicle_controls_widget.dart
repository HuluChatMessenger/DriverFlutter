import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_colors.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle_models.dart';

import '../bloc/bloc.dart';

class VehicleControlsWidget extends StatefulWidget {
  final Configuration configuration;
  VehicleModels? selectedModel;
  VehicleColors? selectedColor;
  String? enteredPlate;
  String? enteredMakeYear;

  VehicleControlsWidget({
    Key? key,
    required this.configuration,
    this.selectedModel,
    this.selectedColor,
    this.enteredPlate,
    this.enteredMakeYear,
  }) : super(key: key);

  @override
  _VehicleControlsWidgetState createState() => _VehicleControlsWidgetState();
}

class _VehicleControlsWidgetState extends State<VehicleControlsWidget> {
  final controllerPlate = TextEditingController();
  final controllerMakeYear = TextEditingController();
  String? inputModel;
  String? inputColor;
  String? inputPlateNo;
  String? inputMakeYear;
  bool isErrVisibleModel = false;
  bool isErrVisibleColor = false;
  bool isBtnEnabled = false;
  var colorsBtnBack = Colors.grey.shade300;
  Color colorsBtnTxt = Colors.grey;

  final _formKey = GlobalKey<FormState>();

  _VehicleControlsWidgetState() {
    Future.delayed(const Duration(microseconds: 5), () {
      if (widget.enteredPlate != null &&
          widget.enteredPlate?.isNotEmpty == true) {
        controllerPlate.text = widget.enteredPlate!;
      }
      if (widget.enteredMakeYear != null &&
          widget.enteredMakeYear?.isNotEmpty == true) {
        controllerMakeYear.text = widget.enteredMakeYear!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'strAddVehicleTitle'.tr,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          DropdownButton<VehicleModels>(
            hint: Text('strModel'.tr),
            isExpanded: true,
            items: widget.configuration.vehicleModels.map((List<String> value) {
              String key = '';
              String label = '';
              if (value.length > 1) {
                key = value.elementAt(0);
                label = value.elementAt(1);
              }
              VehicleModels vehicleModel =
                  VehicleModels(vehicleModelKey: key, vehicleModelLabel: label);
              return DropdownMenuItem<VehicleModels>(
                value: vehicleModel,
                child: Text(vehicleModel.vehicleModelLabel),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  inputModel = value.vehicleModelKey;
                  widget.selectedModel = value;
                }
              });
              setBtnEnabled();
            },
            value: widget.selectedModel,
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: isErrVisibleModel,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: Row(
                children: [
                  Text('errMsgModel'.tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ),
          DropdownButton<VehicleColors>(
            hint: Text('strColor'.tr),
            isExpanded: true,
            items: widget.configuration.vehicleColors.map((VehicleColors value) {
              return DropdownMenuItem<VehicleColors>(
                value: value,
                child: Text(value.vehicleColorLabel),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  inputColor = value.vehicleColorKey;
                  widget.selectedColor = value;
                }
              });
              setBtnEnabled();
            },
            value: widget.selectedColor,
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: isErrVisibleColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: Row(
                children: [
                  Text('errMsgColor'.tr,
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
            controller: controllerPlate,
            keyboardType: TextInputType.text,
            inputFormatters: [LengthLimitingTextInputFormatter(13)],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppConstants.strPromptPlateNo,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            onChanged: (value) {
              inputPlateNo = value;
              setBtnEnabled();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              String? errorValue;
              if (inputPlateNo == null || inputPlateNo?.isEmpty == true) {
                errorValue = 'errMsgEmptyPlateNo'.tr;
              } else if (inputPlateNo != null && inputPlateNo!.length < 10) {
                errorValue = 'errMsgValidPlateNo'.tr;
              }
              return errorValue;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: controllerMakeYear,
            keyboardType: TextInputType.number,
            inputFormatters: [LengthLimitingTextInputFormatter(4)],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'strPromptMakeYear'.tr,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            onChanged: (value) {
              inputMakeYear = value;
              setBtnEnabled();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              String? errorValue;
              if (inputMakeYear == null || inputMakeYear?.isEmpty == true) {
                errorValue = 'errMsgEmptyMakeYear'.tr;
              } else if (inputMakeYear != null && inputMakeYear!.length < 4) {
                errorValue = 'errMsgValidMakeYear'.tr;
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
                    'strRegisterVehicle'.tr,
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
      isErrVisibleColor =
          !(inputColor != null || inputColor?.isNotEmpty == true);
      isErrVisibleModel =
          !(inputModel != null || inputModel?.isNotEmpty == true);

      if ((_formKey.currentState != null &&
              _formKey.currentState!.validate()) &&
          (inputColor != null || inputColor?.isNotEmpty == true) &&
          (inputModel != null || inputModel?.isNotEmpty == true) &&
          (inputPlateNo != null && inputPlateNo!.length > 9) &&
          (inputMakeYear != null && inputMakeYear!.length == 4)) {
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
    if (inputModel != null &&
        inputColor != null &&
        inputPlateNo != null &&
        inputMakeYear != null) {
      addVehicle(
        inputModel!,
        inputColor!,
        inputPlateNo!,
        inputMakeYear!,
      );
    }
  }

  void addVehicle(
    String inputModel,
    String inputColor,
    String inputPlateNo,
    String inputMakeYear,
  ) {
    FocusManager.instance.primaryFocus?.unfocus();

    BlocProvider.of<VehicleBloc>(context).add(
      GetVehicle(
        Vehicle(
          color: inputColor,
          model: inputModel,
          plateNo: inputPlateNo,
          makeYear: int.parse(inputMakeYear),
        ),
        widget.selectedModel!,
        widget.selectedColor!,
      ),
    );
  }
}
