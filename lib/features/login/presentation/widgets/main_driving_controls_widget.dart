import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../bloc/bloc.dart';

class MainDrivingControlsWidget extends StatefulWidget {
  final Driver driver;
  String time = '00:00:00';
  String estimatedPrice = '0.0';
  String estimatedDistance = '0';

  MainDrivingControlsWidget({Key? key, required this.driver}) : super(key: key);

  @override
  _MainDrivingControlsWidgetState createState() =>
      _MainDrivingControlsWidgetState();
}

class _MainDrivingControlsWidgetState extends State<MainDrivingControlsWidget> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        Center(
          child: Text(
            widget.time,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
            top: 8.0,
            bottom: 8.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        Center(
          child: Text(
            'strDriving'.tr,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16),
              child: CachedNetworkImage(
                width: 52,
                height: 52,
                imageUrl: widget.driver.profilePic?.photo ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
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
                  padding: const EdgeInsets.only(left: 10.0, bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Colors.green,
                        size: 20,
                      ),
                      Text(
                        "${CommonUtils.formatCurrency(widget.estimatedPrice)} ${'strBirr'.tr}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.directions_car,
                        color: Colors.green,
                        size: 20,
                      ),
                      Text(
                        "${CommonUtils.formatCurrency(widget.estimatedDistance)} ${'strKm'.tr}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 32,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
          child: SwipeableButtonView(
            buttonText: 'strSwipeComplete'.tr,
            buttonWidget: const Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.red,
            ),
            activeColor: Colors.red,
            isFinished: isFinished,
            onWaitingProcess: () {
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  isFinished = true;
                });
              });
            },
            onFinish: () async {
              addMainDrivingComplete();
              setState(() {
                isFinished = false;
              });
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  void addMainDrivingComplete() {
    BlocProvider.of<MainBloc>(context).add(GetMainDrivingComplete());
  }
}
