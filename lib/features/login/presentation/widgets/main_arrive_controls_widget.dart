import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';

import '../bloc/bloc.dart';

class MainArriveControlsWidget extends StatefulWidget {
  final Driver driver;
  String estimatedPrice = '0.0';
  String estimatedDistance = '0';

  MainArriveControlsWidget({Key? key, required this.driver}) : super(key: key);

  @override
  _MainArriveControlsWidgetState createState() =>
      _MainArriveControlsWidgetState();
}

class _MainArriveControlsWidgetState extends State<MainArriveControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        Center(
          child: Text(
            'strPickingUp'.tr,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Center(
          child: Text(
            widget.estimatedPrice,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
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
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.elliptical(12, 12),
                    bottomLeft: Radius.elliptical(12, 12),
                    bottomRight: Radius.elliptical(12, 12),
                    topRight: Radius.elliptical(12, 12)),
                color: Colors.green.shade200,
              ),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
          child: MaterialButton(
            onPressed: () => addMainArrived(true),
            color: Colors.green,
            minWidth: MediaQuery.of(context).size.width - 100,
            height: 44,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'strArrived'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
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
            onPressed: () => addMainArrived(false),
            minWidth: MediaQuery.of(context).size.width - 100,
            height: 44,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'strCancelTrip'.tr,
              style: const TextStyle(
                fontSize: 16,
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
    );
  }

  void addMainArrived(bool isArrived) {
    BlocProvider.of<MainBloc>(context).add(GetMainArrived(isArrived));
  }
}
