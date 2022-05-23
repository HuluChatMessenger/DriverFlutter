import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class FeedbackPage extends StatelessWidget {
  final Configuration configuration;

  FeedbackPage({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<FeedbackBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FeedbackBloc>(),
      child: BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is LoadedFeedback) {
            openDone();
          }
        },
        builder: (context, state) {
          if (state is LoadingFeedback) {
            return buildFeedbackWidget(
              context,
              true,
              null,
            );
          } else if (state is ErrorFeedback) {
            return buildFeedbackWidget(
              context,
              false,
              state.message,
            );
          } else {
            return buildFeedbackWidget(
              context,
              false,
              null,
            );
          }
        },
      ),
    );
  }

  Widget buildFeedbackWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
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
            title: Text('strFeedback'.tr),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                backgroundTopCurveWidget(context, null),
                // Content
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      FeedbackControlsWidget(
                        configuration: configuration,
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
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

  void openDone() {
    Get.back();
  }
}
