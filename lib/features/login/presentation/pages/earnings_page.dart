import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning_item.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earnings.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class EarningsPage extends StatelessWidget {
  String selectedEarningType = 'Last 7 Days';
  List<String> earningTypes = [
    'Last 7 Days',
    'Last 14 Days',
    'Month',
    'Last 3 Months',
    'Last 6 Months'
  ];

  EarningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<EarningsBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EarningsBloc>()..add(GetEarningsFirst()),
      child: BlocBuilder<EarningsBloc, EarningsState>(
        builder: (context, state) {
          if (state is LoadingEarningsFirst) {
            return buildEarningWidget(
                context, true, null, earningTypes.elementAt(0), [], 0);
          }
          if (state is LoadingEarnings) {
            return buildEarningWidget(
                context,
                true,
                null,
                earningTypes.elementAt(state.selectedPosition),
                state.earnings,
                state.selectedPosition);
          } else if (state is LoadedEarnings) {
            return buildEarningWidget(
                context,
                false,
                null,
                earningTypes.elementAt(state.selectedPosition),
                state.earnings,
                state.selectedPosition);
          } else if (state is ErrorEarnings) {
            return buildEarningWidget(
                context,
                false,
                state.message,
                earningTypes.elementAt(state.selectedPosition),
                state.earnings,
                state.selectedPosition);
          } else {
            return buildEarningWidget(
                context, false, null, earningTypes.elementAt(0), [], 0);
          }
        },
      ),
    );
  }

  Widget buildEarningWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    String selectedEarningTitle,
    List<Earnings>? earnings,
    int selectedEarning,
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
            title: Text('strEarnings'.tr),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    backgroundTopCurveWidget(context, 224),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 16, right: 16),
                      child: EarningsCardControlsWidget(
                          selectedEarning: selectedEarning,
                          selectedEarningTitle: selectedEarningTitle,
                          earnings: earnings),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 16),
                earningValues(context, earnings, selectedEarning),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
  }

  Widget earningValues(
      BuildContext context, List<Earnings>? earnings, int selectedEarning) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: earningRows(context, earnings, selectedEarning)),
    );
  }

  List<Widget> earningRows(
      BuildContext context, List<Earnings>? earnings, int selectedEarning) {
    var earningRows = <Widget>[];
    if (earnings != null && earnings.isNotEmpty == true) {
      List<EarningItem> earningItems =
          earnings.elementAt(selectedEarning).earningItem!;
      for (EarningItem earning in earningItems) {
        Widget earningRow = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: <Widget>[
                Text(
                  earning.label,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                ),
                const Spacer(),
                Text(
                  "${CommonUtils.formatCurrency(earning.totalEarning.toString())} ${'strBirr'.tr}",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 0.1,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        );

        earningRows.add(earningRow);
      }
    }

    return earningRows;
  }

  Widget loading(bool isLoading) {
    if (isLoading) {
      return const LoadingWidget();
    } else {
      return Container();
    }
  }

  Widget error(String? errMsg) {
    if (errMsg != null && errMsg.isNotEmpty) {
      return DialogWidget(
        message: errMsg,
        isDismiss: true,
        typeDialog: AppConstants.dialogTypeErr,
      );
    } else {
      return Container();
    }
  }
}
