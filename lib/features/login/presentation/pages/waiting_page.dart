import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/main_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<WaitingBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WaitingBloc>(),
      child: Stack(
        children: <Widget>[
          backgroundWaitingWidget(context),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            child: Text(AppConstants.strThanks),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            child: Text(AppConstants.strWaitingTxt),
                          ),
                          WaitingWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<WaitingBloc, WaitingState>(
            builder: (context, state) {
              if (state is EmptyWaiting) {
                return WaitingWidget();
              } else if (state is LoadingWaiting) {
                return const LoadingWidget();
              } else {
                return Container();
              }
            },
            listener: (context, state) {
              print('LogHulu : $state');
              if (state is LoadedWaiting) {
                openPageMain();
              }
            },
          ),
        ],
      ),
    );
  }

  void openPageMain() {
    Get.to(() => const MainPage());
  }
}
