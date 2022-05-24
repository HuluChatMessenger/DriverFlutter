import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip_item.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/trip_detail_page.dart';

class TripItemsControlsWidget extends StatefulWidget {
  final Trip trip;

  TripItemsControlsWidget({
    Key? key,
    required this.trip,
  }) : super(key: key) {
    print("LogHulu Trip Loaded: Controls $trip ===results");
  }

  @override
  _TripItemsControlsWidgetState createState() =>
      _TripItemsControlsWidgetState();
}

class _TripItemsControlsWidgetState extends State<TripItemsControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          String? next = getNext();
          if (next != null) {
            addTripNext(next);
          }
        }
        return true;
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: tripRows(context)),
      ),
    );
  }

  List<Widget> tripRows(BuildContext context) {
    var tripRows = <Widget>[];
    if (widget.trip.results != null) {
      for (TripItem tripItem in widget.trip.results) {
        Widget walletRow = InkWell(
          onTap: () {
            onItemClick(tripItem);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleBar(tripItem),
              const SizedBox(
                height: 8,
              ),
              Row(children: <Widget>[
                const SizedBox(
                  width: 8,
                ),
                Column(children: <Widget>[
                  Text(
                    CommonUtils.checkTime(
                        tripItem.createdAt.split("T")[1].substring(0, 5)),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    CommonUtils.checkMode(
                        tripItem.createdAt.split("T")[1].substring(0, 2)),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    tripItem.createdAt.split("T")[0],
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                ]),
                const SizedBox(
                  width: 8,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const Icon(
                            Icons.location_on_sharp,
                            color: Colors.green,
                            size: 32,
                          ),
                          Text(
                            getDisplayName(tripItem.pickUpDisplayName),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const Icon(
                            Icons.location_on_sharp,
                            color: Colors.red,
                            size: 32,
                          ),
                          Text(
                            getDisplayName(tripItem.dropOffDisplayName),
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
                const SizedBox(
                  width: 8,
                ),
              ]),
              const SizedBox(height: 16),
            ],
          ),
        );

        tripRows.add(walletRow);
      }
    }

    return tripRows;
  }

  String getDisplayName(String initialName) {
    String updatedName = initialName;
    int index = initialName.indexOf(",");
    if (!(index > 0)) {
      index = initialName.indexOf("-");
    }
    if (!(index > 0)) {
      index = initialName.indexOf("|");
    }

    if (index > 0 && index < initialName.length) {
      updatedName = initialName.substring(0, index); //this will give abc
    }
    return updatedName;
  }

  Widget titleBar(TripItem tripItem) {
    if (tripItem.isTitle == true && tripItem.subTitle != null) {
      return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: <Widget>[
            Text(
              "${'strToday'.tr}, ",
              style: const TextStyle(
                  fontSize: 32,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              tripItem.subTitle!,
              style: TextStyle(fontSize: 24, color: Colors.grey.shade500),
            ),
          ]),
        ),
      );
    } else if (tripItem.isTitle == true) {
      return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'strToday'.tr,
            style: const TextStyle(
                fontSize: 32, color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else if (tripItem.isSubTitle == true && tripItem.subTitle != null) {
      return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            tripItem.subTitle!,
            style: TextStyle(fontSize: 24, color: Colors.grey.shade500),
          ),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    }
  }

  String? getNext() {
    String? nextString = widget.trip.next;
    String? next = nextString.split("page=").elementAt(1);
    return next;
  }

  void onItemClick(TripItem tripItem) {
    Get.to(() => TripDetailPage(
          tripItem: tripItem,
        ));
  }

  void addTripNext(String next) {
    BlocProvider.of<HistoryBloc>(context).add(GetHistory(next, widget.trip));
  }
}
