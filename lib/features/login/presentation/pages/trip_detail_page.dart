import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
    ));
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
            title: Text('strTripDetail'.tr),
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
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(tripItem.pickUpStreetName,
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(tripItem.pickUpDisplayName,
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
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
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(tripItem.dropOffDisplayName,
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          Text('strTime'.tr,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(tripItem.durationText,
                              style: const TextStyle(
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
                          Text('strPrice'.tr,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${CommonUtils.formatCurrency(tripItem.price)} ${'strBirr'.tr}",
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: <Widget>[
                          Text('strDistance'.tr,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(tripItem.distanceText,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('strDate'.tr,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(tripItem.createdAt.split("T")[0],
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('strStatus'.tr,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(tripItem.status.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
