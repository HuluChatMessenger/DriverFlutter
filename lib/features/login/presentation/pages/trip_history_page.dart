import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/trip.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class TripHistoryPage extends StatelessWidget {
  bool isFirst = true;

  TripHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<HistoryBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HistoryBloc>(),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is LoadingHistory) {
            return buildHistoryWidget(context, true, null, null);
          } else if (state is LoadingHistoryNext) {
            Trip trip = state.trip;
            print("LogHulu Loading Next: $trip");
            return buildHistoryWidget(context, true, null, trip);
          } else if (state is LoadedHistory) {
            Trip trip = state.trip;
            print("LogHulu Result First: $trip");
            return buildHistoryWidget(context, false, null, trip);
          } else if (state is LoadedHistoryNext) {
            Trip trip = state.trip;
            print("LogHulu Result Next: $trip");
            return buildHistoryWidget(context, false, null, trip);
          } else if (state is ErrorHistory) {
            return buildHistoryWidget(context, false, state.message, null);
          } else if (state is ErrorHistoryNext) {
            Trip trip = state.trip;
            return buildHistoryWidget(context, false, state.message, trip);
          } else {
            return buildHistoryWidget(context, false, null, null);
          }
        },
      ),
    );
  }

  Widget buildHistoryWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    Trip? trip,
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
            title: const Text(AppConstants.strTripHistory),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                tripLoaded(trip),
                tripLoading(),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
  }

  Widget tripLoaded(Trip? trip) {
    print("LogHulu Trip Loaded: $trip ===results");
    if (trip != null) {
      return TripItemsControlsWidget(trip: trip);
    } else {
      return Container();
    }
  }

  Widget tripLoading() {
    bool isFirstTime = isFirst;
    isFirst = false;
    return TripControlsWidget(
      isFirst: isFirstTime,
    );
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
