import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/airtime_success.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class HuluCoinPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String balanceCoin = AppConstants.str0;
  String balanceFuel = AppConstants.str0;

  HuluCoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<CoinBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CoinBloc>()..add(GetCoinBalance()),
      child: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is LoadingCoinBalance) {
            return buildHuluCoinWidget(
                context, true, null, null, null, null, null);
          } else if (state is LoadingCoinBuyAirtime) {
            return buildHuluCoinWidget(context, true, null,
                state.currentBalance, state.service, null, null);
          } else if (state is ErrorCoinBalance) {
            return buildHuluCoinWidget(
                context, false, state.message, null, null, null, null);
          } else if (state is ErrorCoinBuyAirtime) {
            return buildHuluCoinWidget(context, false, state.message,
                state.currentBalance, state.service, null, null);
          } else if (state is LoadedCoinBalance) {
            return buildHuluCoinWidget(context, false, null,
                state.currentBalance, state.service, null, null);
          } else if (state is LoadedCoinBuyAirtime) {
            return buildHuluCoinWidget(
                context,
                false,
                null,
                state.airtimeSuccess.balance,
                state.service,
                true,
                state.airtimeSuccess);
          } else {
            return buildHuluCoinWidget(
                context, false, null, null, null, null, null);
          }
        },
      ),
    );
  }

  Widget buildHuluCoinWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    double? balance,
    Service? service,
    bool? isSuccess,
    AirtimeSuccess? airtimeSuccess,
  ) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: scaffoldKey,
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
            title: Text('strHuluCoin'.tr),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Container(
                      height: 264,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/drawerbg.jpg')),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.white,
                                            spreadRadius: 1)
                                      ],
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/ic_hulucoin_card.png'),
                                          // picked file
                                          fit: BoxFit.fill)),
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 8.0, bottom: 24),
                                  child: Text(
                                    'strHuluCoin'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 44,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 44.0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'strCurrentBalance'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'strWalletMember'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  currentBalance(balance),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Spacer(),
                                const Text(
                                  AppConstants.strWalletDate,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (service == null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('strBuyAirtime'.tr),
                              content: Text('errMsgAirtime'.tr),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('strCancel'.tr))
                              ],
                            ),
                          );
                        } else {
                          scaffoldKey.currentState?.showBottomSheet(
                            (context) => CoinAirtimeControlsWidget(
                              service: service,
                              currentBalance: balance!,
                            ),
                          );
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.elliptical(8, 8)),
                            color: Colors.grey.shade100,
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 8,
                              ),
                              const Icon(
                                Icons.sim_card,
                                color: Colors.green,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'strBuyAirtime'.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  const Spacer(),
                                  Text(
                                    balanceCoin,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/hulucoin.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('strFuelCoupon'.tr),
                            content: Text('msgFuelCoupon'.tr),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('strCancel'.tr))
                            ],
                          ),
                        );
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.elliptical(8, 8)),
                            color: Colors.grey.shade100,
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 8,
                              ),
                              const Icon(
                                Icons.local_gas_station,
                                color: Colors.green,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'strFuelCoupon'.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  const Spacer(),
                                  Text(
                                    balanceFuel,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/hulucoin.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
        success(isSuccess, airtimeSuccess)
      ],
    );
  }

  String currentBalance(double? balance) {
    if (balance != null) {
      return balance.toString();
    } else {
      return AppConstants.str0;
    }
  }

  Widget loading(bool isLoading) {
    if (isLoading) {
      return const LoadingWidget();
    } else {
      return Container();
    }
  }

  Widget success(bool? isSuccess, AirtimeSuccess? airtimeSuccess) {
    if (isSuccess == true) {
      String textSuccess =
          "${airtimeSuccess?.amount} ${'strBirr'.tr} ${'msgAirtimeSuccessStart'.tr} +${airtimeSuccess?.phoneNumber} ${'msgAirtimeSuccessEnd'.tr} ";
      return DialogWidget(
        message: textSuccess,
        isDismiss: true,
        typeDialog: AppConstants.dialogTypeMsg,
      );
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
