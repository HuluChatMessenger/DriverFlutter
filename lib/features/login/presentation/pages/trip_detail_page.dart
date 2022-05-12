import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip_item.dart';

import '../../../../core/util/common_utils.dart';
import '../widgets/widgets.dart';

class TripDetailPage extends StatelessWidget {
  TripItem tripItem;

  TripDetailPage({Key? key, required this.tripItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(
    BuildContext context,
  ) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                );
              },
            ),
            elevation: 0,
            title: const Text(AppConstants.strTripDetail),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                backgroundTopCurveWidget(context, null),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on_sharp,
                                color: Colors.green,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(tripItem.pickUpStreetName,
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(tripItem.pickUpDisplayName,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 16.0, bottom: 16.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on_sharp,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(tripItem.dropOffStreetName,
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(tripItem.dropOffDisplayName,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          Text(AppConstants.strTime,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(tripItem.durationText,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: <Widget>[
                          Text(AppConstants.strPrice,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              CommonUtils.formatCurrency(tripItem.price) +
                                  " " +
                                  AppConstants.strBirr,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: <Widget>[
                          Text(AppConstants.strDistance,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(tripItem.distanceText,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppConstants.strDate,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(tripItem.createdAt.split("T")[0],
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppConstants.strStatus,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(tripItem.status.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
