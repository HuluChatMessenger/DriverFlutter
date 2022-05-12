import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/wallet_transactions.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class WalletPage extends StatelessWidget {
  bool isFirst = true;
  Driver driver;
  String username = AppConstants.strAppName;
  String balance = "0.0";

  WalletPage({Key? key, required this.driver}) : super(key: key) {
    String name = '${driver.fName} ${driver.mName} ${driver.lName}';
    username = name.isNotEmpty ? name : username;
    balance = driver.driverWallet.balance;
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<WalletBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WalletBloc>(),
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is LoadingWallet) {
            return buildWalletWidget(context, true, null, null);
          } else if (state is LoadingWalletNext) {
            WalletTransactions transactions = state.walletTransactions;
            print("LogHulu Loading Next: $transactions");
            return buildWalletWidget(context, true, null, transactions);
          } else if (state is LoadedWallet) {
            WalletTransactions transactions = state.walletTransactions;
            print("LogHulu Result First: $transactions");
            return buildWalletWidget(context, false, null, transactions);
          } else if (state is LoadedWalletNext) {
            WalletTransactions transactions = state.walletTransactions;
            print("LogHulu Result Next: $transactions");
            return buildWalletWidget(context, false, null, transactions);
          } else if (state is ErrorWallet) {
            return buildWalletWidget(context, false, state.message, null);
          } else if (state is ErrorWalletNext) {
            WalletTransactions transactions = state.walletTransactions;
            return buildWalletWidget(
                context, false, state.message, transactions);
          } else {
            return buildWalletWidget(context, false, null, null);
          }
        },
      ),
    );
  }

  Widget buildWalletWidget(
    BuildContext context,
    bool isLoading,
    String? errMsg,
    WalletTransactions? transactions,
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
            title: const Text(AppConstants.strWallet),
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
                                              'assets/images/logo_drawer.png'),
                                          // picked file
                                          fit: BoxFit.fill)),
                                ),
                                const Spacer(),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(right: 8.0, bottom: 24),
                                  child: Text(
                                    AppConstants.strAppName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              AppConstants.strWalletNo,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 32.0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 16,
                                ),
                                const Spacer(),
                                const Text(
                                  AppConstants.strWalletMember,
                                  style: TextStyle(
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
                                  username,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
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
                const Text(
                  AppConstants.strWalletBalance,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  CommonUtils.formatCurrency(balance) +
                      " " +
                      AppConstants.strBirr,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(AppConstants.strSend),
                            content: Text(AppConstants.strComingSoon),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppConstants.strCancel))
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
                            children: const <Widget>[
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.green,
                                size: 40,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                AppConstants.strSend,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              SizedBox(
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
                            title: Text(AppConstants.strDeposit),
                            content: Text(AppConstants.strComingSoon),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppConstants.strCancel))
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
                            children: const <Widget>[
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                Icons.account_balance,
                                color: Colors.green,
                                size: 40,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                AppConstants.strDeposit,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                walletLoaded(transactions),
                walletLoading(),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
  }

  Widget walletLoaded(WalletTransactions? transactions) {
    print("LogHulu Wallet Loaded: $transactions ===results");
    if (transactions != null) {
      return WalletTransactionsControlsWidget(walletTransactions: transactions);
    } else {
      return Container();
    }
  }

  Widget walletLoading() {
    bool isFirstTime = isFirst;
    isFirst = false;
    return WalletControlsWidget(
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
