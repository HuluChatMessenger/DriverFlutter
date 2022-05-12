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

class AppDrawer extends StatelessWidget {
  final Configuration configuration;
  final Driver driver;
  String username = AppConstants.strAppName;
  String picProfile = 'assets/images/logo_drawer.png';
  final String defaultPicProfile = 'assets/images/logo_drawer.png';

  AppDrawer({required this.driver, required this.configuration}) {
    String name = '${driver.fName} ${driver.mName} ${driver.lName}';
    username = name.isNotEmpty ? name : username;
    picProfile = driver.profilePic?.photo ?? picProfile;
  }

  void goWallet() {
    Get.to(() => WalletPage(driver: driver,));
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
            text: AppConstants.strWallet,
            onTap: goWallet,
          ),
          _createDrawerItem(
            icon: Icons.history_outlined,
            text: AppConstants.strTripHistory,
            onTap: goTripHistory,
          ),
          _createDrawerItem(
            icon: Icons.attach_money_outlined,
            text: AppConstants.strEarnings,
            onTap: goEarnings,
          ),
          _createDrawerItem(
            icon: Icons.attach_file_outlined,
            text: AppConstants.strDocuments,
            onTap: goDocuments,
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.person_outline,
            text: AppConstants.strMyAccount,
            onTap: goProfile,
          ),
          _createDrawerItemCustomIconPic(
            image: 'assets/images/hulucoin.png',
            text: AppConstants.strHuluCoin,
            onTap: goHuluCoin,
          ),
          _createDrawerItem(
            icon: Icons.contact_mail_outlined,
            text: AppConstants.strFeedback,
            onTap: goFeedback,
          ),
          const Divider(),
          _createDrawerItem(
              icon: Icons.color_lens_outlined, text: AppConstants.strTheme),
          _createDrawerItem(
              icon: Icons.language_outlined, text: AppConstants.strLanguage),
          SizedBox(height: 32),
          const Divider(),
          ListTile(
            title: const Text(
              AppConstants.strTerms,
              textAlign: TextAlign.center,
              style: TextStyle(
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
                  SizedBox(
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
                  SizedBox(
                    height: 4,
                  ),
                  Text(username,
                      style: TextStyle(
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
}
