import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/document_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/earnings_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/feedback_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/hulucoin_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/profile_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/terms_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/trip_history_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/wallet_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_controls_widget.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Configuration configuration;
  final Driver driver;
  String username = AppConstants.strAppName;
  String picProfile = 'assets/images/logo_drawer.png';
  final String defaultPicProfile = 'assets/images/logo_drawer.png';

  AppDrawer(
      {required this.driver,
      required this.configuration,
      required this.scaffoldKey}) {
    String name = '${driver.fName} ${driver.mName} ${driver.lName}';
    username = name.isNotEmpty ? name : username;
    picProfile = driver.profilePic?.photo ?? picProfile;
  }

  void goWallet() {
    Get.to(() => WalletPage(
          driver: driver,
        ));
  }

  void goTripHistory() {
    Get.to(() => TripHistoryPage());
  }

  void goEarnings() {
    Get.to(() => EarningsPage());
  }

  void goDocuments() {
    Get.to(() => DocumentPage(
          documentTypes: configuration.documentTypes,
          documents:
              driver.driverDocuments != null ? driver.driverDocuments! : [],
          isSplash: false,
          configuration: configuration,
        ));
  }

  void goHuluCoin() {
    Get.to(() => HuluCoinPage());
  }

  void goFeedback() {
    Get.to(() => FeedbackPage(configuration: configuration));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(username, picProfile, driver.avgRating.toDouble()),
          _createDrawerItem(
            icon: Icons.account_balance_wallet_outlined,
            text: 'strWallet'.tr,
            onTap: goWallet,
          ),
          _createDrawerItem(
            icon: Icons.history_outlined,
            text: 'strTripHistory'.tr,
            onTap: goTripHistory,
          ),
          _createDrawerItem(
            icon: Icons.attach_money_outlined,
            text: 'strEarnings'.tr,
            onTap: goEarnings,
          ),
          _createDrawerItem(
            icon: Icons.attach_file_outlined,
            text: 'strDocuments'.tr,
            onTap: goDocuments,
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.person_outline,
            text: 'strMyAccount'.tr,
            onTap: goProfile,
          ),
          _createDrawerItemCustomIconPic(
            image: 'assets/images/hulucoin.png',
            text: 'strHuluCoin'.tr,
            onTap: goHuluCoin,
          ),
          _createDrawerItem(
            icon: Icons.contact_mail_outlined,
            text: 'strFeedback'.tr,
            onTap: goFeedback,
          ),
          const Divider(),
          _createDrawerItem(
              icon: Icons.color_lens_outlined, text: 'strTheme'.tr),
          _createDrawerItem(
              icon: Icons.language_outlined,
              text: 'strLanguage'.tr,
              onTap: () async {
                scaffoldKey.currentState!.closeDrawer();
                await goLanguages(context);
              }),
          const SizedBox(height: 32),
          const Divider(),
          ListTile(
            title: Text(
              'strTerms'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            onTap: goTerms,
          ),
        ],
      ),
    );
  }

  Widget _createHeader(String username, String picProfile, double rating) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/drawerbg.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 8.0,
              right: 8.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: goProfile,
                    child: CachedNetworkImage(
                      width: 92,
                      height: 92,
                      imageUrl: picProfile,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(color: Colors.white, spreadRadius: 1)
                            ],
                            image: DecorationImage(
                                image: imageProvider,
                                // picked file
                                fit: BoxFit.fill)),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(color: Colors.white, spreadRadius: 1)
                            ],
                            image: DecorationImage(
                                image: AssetImage(defaultPicProfile),
                                // picked file
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    itemCount: 5,
                    itemSize: 16.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(username,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ],
              )),
        ]));
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createDrawerItemCustomIconPic(
      {required String image, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void goProfile() {
    Get.to(() => ProfilePage(
          driver: driver,
        ));
  }

  void goTerms() {
    Get.to(() => const TermsPage());
  }

  Future<void> goLanguages(BuildContext context) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    showModalBottomSheet(
        context: context,
        elevation: 0,
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        builder: (context) => LanguageControlsWidget(
              sharedPreferences: preference,
            ));
  }
}
