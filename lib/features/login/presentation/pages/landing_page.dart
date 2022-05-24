import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/login_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class LandingPage extends StatelessWidget {
  final bool isReferral;
  final Configuration configuration;

  LandingPage({Key? key, required this.isReferral, required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
    ));
    return Stack(
      children: <Widget>[
        backgroundLandingWidget(context),
        Positioned(
          bottom: 24,
          right: 16,
          left: 16,
          child: Center(
            child: Flexible(
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
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
                    mainAxisAlignment: MainAxisAlignment.center,
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

                          showModalBottomSheet(
                              context: context,
                              elevation: 0,
                              barrierColor: Colors.black.withAlpha(1),
                              backgroundColor: Colors.transparent,
                              builder: (context) => LanguageControlsWidget(
                                    sharedPreferences: preference,
                                  ));
                        },
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Material(
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences preference =
                                  await getSharedPreference();
                              showModalBottomSheet(
                                  context: context,
                                  elevation: 0,
                                  barrierColor: Colors.black.withAlpha(1),
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => LanguageControlsWidget(
                                        sharedPreferences: preference,
                                      ));
                            },
                            child: SvgPicture.asset('assets/icons/et.svg',
                                semanticsLabel: 'Top Curve'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
    Get.to(() => LoginPage());
  }
}
