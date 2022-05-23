import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class MainOnlineControlsWidget extends StatefulWidget {
  final Driver driver;
  LatLng locationLatLng;
  bool isTraffic;
  String balance = '0.0';

  MainOnlineControlsWidget(
      {Key? key, required this.driver, required this.locationLatLng, required this.isTraffic})
      : super(key: key);

  @override
  _MainOnlineControlsWidgetState createState() =>
      _MainOnlineControlsWidgetState();
}

class _MainOnlineControlsWidgetState extends State<MainOnlineControlsWidget> {
  bool isBalanceVisible = false;
  bool isSwitchValue = false;
  bool isBtnEnabled = false;
  bool isFinished = false;
  bool isSearch = false;
  var colorsBtnBack = Colors.grey.shade300;
  Color colorsBtnTxt = Colors.grey;
  MaterialColor switchColor = Colors.red;
  Color switchBgColor = Colors.green.shade100;
  String? inputStrPhone;
  String? inputStrSearchLocation;
  LatLng? inputLatLngDropOff;
  final controllerPhone = TextEditingController();
  final controllerSearch = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16),
              child: CachedNetworkImage(
                width: 64,
                height: 64,
                imageUrl: widget.driver.profilePic?.photo ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: (isSwitchValue) ? Colors.green : Colors.red,
                            spreadRadius: 4)
                      ],
                      image: DecorationImage(
                          image: imageProvider,
                          // picked file
                          fit: BoxFit.fill)),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Container(
                  width: 92,
                  height: 92,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.white, spreadRadius: 1)
                      ],
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo_drawer.png'),
                          // picked file
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    (isSwitchValue) ? 'strOnline'.tr : 'strOffline'.tr,
                    style: TextStyle(
                        color: (isSwitchValue) ? Colors.green : Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, top: 4),
                  child: Text(
                    widget.driver.fName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isBalanceVisible = !isBalanceVisible;
                          });
                        },
                        icon: Icon(
                          (isBalanceVisible)
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.green,
                          size: 24,
                        )),
                    const Icon(
                      Icons.attach_money,
                      color: Colors.green,
                      size: 24,
                    ),
                    Text(
                      (isBalanceVisible)
                          ? "${CommonUtils.formatCurrency(widget.balance)} ${'strBirr'.tr}"
                          : AppConstants.strBalanceHidden,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            switchBtn(),
            const SizedBox(
              width: 32,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        pickUpBtn(),
      ],
    );
  }

  Widget pickUpBtn() {
    if (isSwitchValue) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('strStreetPickUp'.tr),
                  content: onClickStreetPickup(),
                  backgroundColor: Colors.grey.shade200,
                ),
              );
            },
            color: Colors.green,
            textColor: Colors.white,
            minWidth: MediaQuery.of(context).size.width,
            height: 64,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'strStreetPickUp'.tr,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.person_add_alt_1,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            )),
      );
    } else {
      return const SizedBox(
        height: 16,
      );
    }
  }

  Widget onClickStreetPickup() {
    return Container(
      height: 364,
      width: MediaQuery.of(context).size.width - 100,
      color: Colors.grey.shade200,
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: controllerPhone,
              keyboardType: TextInputType.phone,
              inputFormatters: [LengthLimitingTextInputFormatter(9)],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'strPromptPhone'.tr,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                prefix: SizedBox(
                  width: 64,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset('assets/icons/et.svg',
                            semanticsLabel: 'Country Flag'),
                      ),
                      const SizedBox(width: 4),
                      const Text('+251')
                    ],
                  ),
                ),
                suffix: SizedBox(
                  width: 36,
                  height: 20,
                  child: IconButton(
                      onPressed: () {
                        qrScanner();
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        size: 28,
                        color: Colors.green,
                      )),
                ),
              ),
              onChanged: (value) {
                inputStrPhone = value;
                setBtnStartEnabled();
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
            SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: controllerSearch,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'strPromptLocationDropOff'.tr,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                prefix: SizedBox(
                  width: 32,
                  child: Row(
                    children: const <Widget>[
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                suffix: Visibility(
                  visible: (inputStrSearchLocation != null &&
                      controllerSearch.text.isNotEmpty),
                  child: SizedBox(
                    width: 36,
                    height: 20,
                    child: IconButton(
                        onPressed: () {
                          controllerSearch.text = "";
                          setState(() {
                            inputStrSearchLocation = null;
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 28,
                          color: Colors.red,
                        )),
                  ),
                ),
              ),
              onChanged: (value) {
                inputStrSearchLocation = value;
                setBtnStartEnabled();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                String? errorValue;
                if (inputStrSearchLocation == null ||
                    inputStrSearchLocation?.isNotEmpty == false) {
                  errorValue = 'errMsgEmptyLocation'.tr;
                } else {
                  errorValue = null;
                }
                return errorValue;
              },
            ),
            Visibility(
                visible: isSearch,
                child: const SizedBox(
                  height: 148,
                )),
            Visibility(
                visible: isSearch != true,
                child: const SizedBox(
                  height: 72,
                )),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
              child: SwipeableButtonView(
                buttonText: 'strSwipeStart'.tr,
                buttonWidget: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.green,
                ),
                activeColor: Colors.green,
                isFinished: isFinished,
                onWaitingProcess: () {
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      isFinished = true;
                    });
                  });
                },
                onFinish: () async {
                  if (inputStrPhone != null && inputLatLngDropOff != null) {
                    addMainPickUp(inputStrPhone!, inputLatLngDropOff!);
                  }
                  setState(() {
                    isFinished = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void qrScanner() {
    // Get.to(() => QRControlsWidget(
    //   contextBloc: context,
    // ));
  }

  Widget switchBtn() {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
        return buildCupertinoSwitch();
      default:
        return buildMaterialSwitch();
    }
  }

  Widget buildMaterialSwitch() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Transform.scale(
        scale: 3,
        child: Switch(
            value: isSwitchValue,
            inactiveThumbColor: switchColor,
            activeColor: switchColor,
            activeTrackColor: switchBgColor,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: (value) {
              setState(() {
                isSwitchValue = value;
                switchColor = (value == true) ? Colors.green : Colors.red;
                switchBgColor = (value == true)
                    ? Colors.green.shade100
                    : Colors.grey.shade500;
                addMainOnOffLine(value);
              });
            }),
      ),
    );
  }

  void setBtnStartEnabled() {
    setState(() {
      if ((_formKey.currentState != null &&
              _formKey.currentState!.validate()) &&
          (inputStrPhone != null && inputStrPhone?.length == 9)) {
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

  Widget buildCupertinoSwitch() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Transform.scale(
        scale: 2,
        child: CupertinoSwitch(
            value: isSwitchValue,
            thumbColor: switchColor,
            activeColor: switchBgColor,
            trackColor: switchBgColor,
            onChanged: (value) {
              setState(() {
                isSwitchValue = value;
                switchColor = (value == true) ? Colors.green : Colors.red;
                switchBgColor = (value == true)
                    ? Colors.green.shade100
                    : Colors.grey.shade500;
                addMainOnOffLine(value);
              });
            }),
      ),
    );
  }

  void addMainOnOffLine(bool isSetOnline) {
    BlocProvider.of<MainBloc>(context)
        .add(GetMainOnOffline(isSetOnline, widget.locationLatLng, widget.isTraffic));
  }

  void addMainPickUp(String phoneNumber, LatLng dropOffLocation) {
    BlocProvider.of<MainBloc>(context).add(
        GetMainPickup(phoneNumber, dropOffLocation, widget.locationLatLng, widget.isTraffic));
  }
}
