import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';

import '../bloc/bloc.dart';

class CoinAirtimeControlsWidget extends StatefulWidget {
  final Service service;
  final double currentBalance;

  const CoinAirtimeControlsWidget(
      {Key? key, required this.service, required this.currentBalance})
      : super(key: key);

  @override
  _CoinAirtimeControlsWidgetState createState() => _CoinAirtimeControlsWidgetState();
}

class _CoinAirtimeControlsWidgetState extends State<CoinAirtimeControlsWidget> {
  double selectedAmount = 0.0;
  var colorsBtnBack = Colors.grey.shade500;
  Color colorsBtnTxt = Colors.grey.shade300;
  var colorsBtnBackSelection50 = Colors.white;
  Color colorsBtnTxtSelection50 = Colors.green;
  var colorsBtnBackSelection100 = Colors.white;
  Color colorsBtnTxtSelection100 = Colors.green;
  bool isBtnEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.elliptical(24, 24),
            topRight: Radius.elliptical(24, 24)),
        color: Colors.grey.shade200,
      ),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Column(
            children: <Widget>[
               Text(
                'strBuyAirtime'.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                selectedAmount.toString(),
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.normal,
                    fontSize: 64),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'strCoinDesc'.tr,
                style: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    selectedAmount = 50.0;
                    colorsBtnBack = Colors.green;
                    colorsBtnTxt = Colors.white;
                    isBtnEnabled = true;

                    colorsBtnBackSelection50 = Colors.green.shade300;
                    colorsBtnTxtSelection50 = Colors.white;
                    colorsBtnBackSelection100 = Colors.white;
                    colorsBtnTxtSelection100 = Colors.green;
                  });
                },
                color: colorsBtnBackSelection50,
                height: 32,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'strCoin50'.tr,
                  style:  TextStyle(
                    fontSize: 14,
                    color: colorsBtnTxtSelection50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    selectedAmount = 100.0;
                    colorsBtnBack = Colors.green;
                    colorsBtnTxt = Colors.white;
                    isBtnEnabled = true;

                    colorsBtnBackSelection50 = Colors.white;
                    colorsBtnTxtSelection50 = Colors.green;
                    colorsBtnBackSelection100 = Colors.green.shade300;
                    colorsBtnTxtSelection100 = Colors.white;
                  });
                },
                color: colorsBtnBackSelection100,
                height: 32,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'strCoin100'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorsBtnTxtSelection100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
            child: MaterialButton(
              onPressed: (isBtnEnabled) ? onBtnClicked : null,
              color: colorsBtnBack,
              disabledColor: colorsBtnBack,
              minWidth: MediaQuery.of(context).size.width - 100,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'strSubmit'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color: colorsBtnTxt,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              minWidth: MediaQuery.of(context).size.width - 100,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'strCancel'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void onBtnClicked() {
    if (selectedAmount == 50.0 || selectedAmount == 100.0) {
      Navigator.pop(context);
      addCoin();
    }
  }

  void addCoin() {
    BlocProvider.of<CoinBloc>(context).add(GetCoinBuyAirtime(
        widget.currentBalance, selectedAmount, widget.service));
  }
}
