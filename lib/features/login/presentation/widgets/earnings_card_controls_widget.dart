import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning_item.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';

import '../../../../core/util/text_symbol_renderer.dart';
import '../bloc/bloc.dart';

class EarningsCardControlsWidget extends StatefulWidget {
  double? selectedBar = 0.0;
  int selectedEarning;
  String selectedEarningTitle;
  String totalEarning = '0.0';
  String totalTrips = '0.0';
  String totalOnlineHrs = '0:0';
  List<Earnings>? earnings;
  List<EarningItem>? earningItems;

  EarningsCardControlsWidget({
    Key? key,
    required this.selectedEarning,
    required this.selectedEarningTitle,
    required this.earnings,
  }) : super(key: key) {
    if (earnings != null &&
        earnings?.isNotEmpty == true &&
        selectedEarning < earnings!.length &&
        earnings!.elementAt(selectedEarning) != null &&
        earnings!.elementAt(selectedEarning).earning != null) {
      Earning earning = earnings!.elementAt(selectedEarning).earning!;
      earningItems = earnings!.elementAt(selectedEarning).earningItem;
      totalEarning = earning.totalEarnings.toString();
      totalTrips = earning.tripCounts.toString();
      totalOnlineHrs = earning.totalOnlineHr.toString();
    }
  }

  @override
  _EarningsCardControlsWidgetState createState() =>
      _EarningsCardControlsWidgetState();
}

class _EarningsCardControlsWidgetState
    extends State<EarningsCardControlsWidget> {
  List<String> earningTypes = [
    'Last 7 Days',
    'Last 14 Days',
    'Month',
    'Last 3 Months',
    'Last 6 Months'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
          color: Colors.grey.shade200,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                hint: Text(widget.selectedEarningTitle),
                isExpanded: true,
                items: earningTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      widget.selectedEarningTitle = value;
                    }
                  });
                  if (value == earningTypes.elementAt(0)) {
                    earningsLoaded(widget.earnings, 0);
                  } else if (value == earningTypes.elementAt(1)) {
                    earningsLoaded(widget.earnings, 1);
                  } else if (value == earningTypes.elementAt(2)) {
                    earningsLoaded(widget.earnings, 2);
                  } else if (value == earningTypes.elementAt(3)) {
                    earningsLoaded(widget.earnings, 3);
                  } else if (value == earningTypes.elementAt(4)) {
                    earningsLoaded(widget.earnings, 4);
                  }
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 64,
                    ),
                    Text(
                      'strBirr'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
              child: Text(
                CommonUtils.formatCurrency(widget.totalEarning),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            barChart(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.totalTrips,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'strTrips'.tr,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  height: 76,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.totalOnlineHrs,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'strOnlineHrs'.tr,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget barChart() {
    if (widget.earningItems != null &&
        widget.earningItems?.isNotEmpty == true) {
      return SizedBox(
        width: MediaQuery.of(context).size.width - 64,
        height: 300,
        child: charts.BarChart(
          prepareBarChart(widget.earningItems!),
          animate: true,
          domainAxis: charts.OrdinalAxisSpec(
            viewport: charts.OrdinalViewport('AePS', 3),
          ),
          behaviors: [
            charts.SeriesLegend(),
            charts.SlidingViewport(),
            charts.PanAndZoomBehavior(),
            charts.LinePointHighlighter(
              symbolRenderer: TextSymbolRenderer(() => (widget.selectedBar !=
                      null)
                  ? ('${widget.selectedBar} ${'strBirr'.tr}')
                  : ''),
            ),
          ],
          selectionModels: [
            charts.SelectionModelConfig(
                changedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                widget.selectedBar = model.selectedSeries[0]
                    .measureFn(model.selectedDatum[0].index)
                    ?.toDouble();
              }
            })
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  List<charts.Series<dynamic, String>> prepareBarChart(
      List<EarningItem> earningItems) {
    return [
      charts.Series<EarningItem, String>(
          id: chartTitle(),
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (EarningItem earning, _) => earning.label,
          measureFn: (EarningItem earning, _) => earning.totalEarning,
          data: earningItems)
    ];
  }

  String chartTitle() {
    String chartTitleStart = '7 Days';
    if (widget.selectedEarning == 1) {
      chartTitleStart = '14 Days';
    } else if (widget.selectedEarning == 2) {
      chartTitleStart = "A Month's";
    } else if (widget.selectedEarning == 3) {
      chartTitleStart = '3 Months';
    } else if (widget.selectedEarning == 4) {
      chartTitleStart = '6 Months';
    }
    return '$chartTitleStart ${'strEarnings'.tr}';
  }

  void earningsLoaded(List<Earnings>? earnings, int selectedEarning) {
    print("LogHulu Earning Loaded: $earnings ===results");
    if (earnings != null) {
      addEarnings(selectedEarning, earnings);
    } else {
      List<Earnings> earnings = [
        Earnings(earning: null, earningItem: []),
        Earnings(earning: null, earningItem: []),
        Earnings(earning: null, earningItem: []),
        Earnings(earning: null, earningItem: []),
        Earnings(earning: null, earningItem: []),
      ];
      addEarnings(selectedEarning, earnings);
    }
  }

  void addEarnings(int pos, List<Earnings> earnings) {
    print("LogHulu Pagination Final: $pos ==== ${earnings} === result");
    if (pos == 0) {
      BlocProvider.of<EarningsBloc>(context)
          .add(GetEarningsLoad(pos, earnings));
    } else if (pos == 1) {
      BlocProvider.of<EarningsBloc>(context)
          .add(GetEarningsLoad(pos, earnings));
    } else if (pos == 2) {
      BlocProvider.of<EarningsBloc>(context)
          .add(GetEarningsLoad(pos, earnings));
    } else if (pos == 3) {
      BlocProvider.of<EarningsBloc>(context)
          .add(GetEarningsLoad(pos, earnings));
    } else if (pos == 4) {
      BlocProvider.of<EarningsBloc>(context)
          .add(GetEarningsLoad(pos, earnings));
    }
  }
}
