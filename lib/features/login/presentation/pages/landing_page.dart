import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/login_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class LandingPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final bool isReferral;
  final Configuration configuration;

  LandingPage({Key? key, required this.isReferral, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          backgroundLandingWidget(context),
          Positioned(
            bottom: 24,
            right: 16,
            left: 16,
            child: Center(
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      openPageRegistration();
                    },
                    color: Colors.green,
                    minWidth: MediaQuery.of(context).size.width - 100,
                    height: 44,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'strRegister'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MaterialButton(
                    onPressed: () {
                      openPageLogin();
                    },
                    minWidth: MediaQuery.of(context).size.width - 100,
                    height: 44,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'strLogin'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          TextButton(
                            child: const Text(AppConstants.strChooseLanguage,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                )),
                            onPressed: () async {
                              SharedPreferences preference =
                                  await getSharedPreference();
                              scaffoldKey.currentState?.showBottomSheet(
                                (context) => LanguageControlsWidget(
                                  sharedPreferences: preference,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () async {
                              SharedPreferences preference =
                                  await getSharedPreference();
                              scaffoldKey.currentState?.showBottomSheet(
                                (context) => LanguageControlsWidget(
                                  sharedPreferences: preference,
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: SvgPicture.asset('assets/icons/et.svg',
                                  semanticsLabel: 'Top Curve'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<SharedPreferences> getSharedPreference() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  void openPageRegistration() {
    Get.to(() => RegistrationPage(
          isReferral: isReferral,
          configuration: configuration,
        ));
  }

  void openPageLogin() {
    Get.to(() => LoginPage(
          configuration: configuration,
        ));
  }
}
