import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/login_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/registration_page.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class LandingPage extends StatelessWidget {
  final bool isReferral;

  const LandingPage({Key? key, required this.isReferral}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  child: const Text(
                    AppConstants.strRegister,
                    style: TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.green,
                  minWidth: MediaQuery.of(context).size.width - 100,
                  height: 44,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                const SizedBox(height: 16),
                MaterialButton(
                  onPressed: () {
                    openPageLogin();
                  },
                  child: const Text(
                    AppConstants.strLogin,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  minWidth: MediaQuery.of(context).size.width - 100,
                  height: 44,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                              AppConstants.strChooseLanguage,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              )),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                              'assets/images/et.svg',
                              semanticsLabel: 'Top Curve'),
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
    );
  }

  void openPageRegistration() {
    Get.to(() => RegistrationPage(
          isReferral: isReferral,
        ));
  }

  void openPageLogin() {
    Get.to(() => LoginPage());
  }
}
