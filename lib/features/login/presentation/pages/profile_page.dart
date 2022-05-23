import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/landing_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  Driver driver;
  String username = AppConstants.strAppName;
  String picProfile = 'assets/images/logo_drawer.png';
  String defaultPicProfile = 'assets/images/logo_drawer.png';
  double rating = 0;
  double totalEarning = 0.0;
  int totalTrips = 0;

  ProfilePage({Key? key, required this.driver}) : super(key: key) {
    String name = '${driver.fName} ${driver.mName} ${driver.lName}';
    username = name.isNotEmpty ? name : username;
    picProfile = driver.profilePic?.photo ?? picProfile;
    rating = driver.avgRating.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<ProfileBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is LogoutProfile) {
            if (state.configuration != null) {
              openPageLanding(state.configuration!.referralProgramEnabled,
                  state.configuration!);
            } else {
              openSplash();
            }
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial) {
            return buildMainWidget(context, false, null);
          } else if (state is LoadingProfile) {
            return buildMainWidget(context, false, null);
          } else if (state is LoadingProfileEarning) {
            return buildMainWidget(context, true, null);
          } else if (state is LoadedProfile) {
            driver = state.driver;
            String name = '${driver.fName} ${driver.mName} ${driver.lName}';
            username = name.isNotEmpty ? name : username;
            picProfile = driver.profilePic?.photo ?? picProfile;
            rating = driver.avgRating.toDouble();
            return buildMainWidget(context, false, null);
          } else if (state is LoadedProfileEarning) {
            totalEarning = state.earning.totalEarnings;
            totalTrips = state.earning.tripCounts;
            return buildMainWidget(context, false, null);
          } else if (state is ErrorProfile) {
            return buildMainWidget(context, false, state.message);
          } else {
            return buildMainWidget(context, false, null);
          }
        },
      ),
    );
  }

  Widget buildMainWidget(
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
            actions: const [
              ProfileLogoutControlsWidget(),
            ],
            elevation: 0,
            title: Text('strMyAccount'.tr),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    backgroundTopCurveProfileWidget(context),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          CachedNetworkImage(
                            width: 92,
                            height: 92,
                            imageUrl: picProfile,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white, spreadRadius: 1)
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
                                    BoxShadow(
                                        color: Colors.white, spreadRadius: 1)
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage(defaultPicProfile),
                                      // picked file
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(username,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
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
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Icon(
                            Icons.monetization_on_outlined,
                            size: 64,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.card_travel_outlined,
                            size: 64,
                            color: Colors.green,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                              "$totalEarning ${'strBirr'.tr}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              "$totalTrips ${'strTrips'.tr}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('strAccountDetailsTitle'.tr,
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone_android_outlined,
                        size: 32,
                        color: Colors.black,
                      ),
                      Text('strPhoneNoTitle'.tr,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('+${driver.phoneNumber}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.qr_code_outlined,
                        size: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('strReferralTitle'.tr,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(driver.userIdn,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 0.3,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('strVehicleDetailsTitle'.tr,
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.directions_car_outlined,
                        size: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('strModelTitle'.tr,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                          driver.vehicle != null
                              ? driver.vehicle!.model.capitalize!
                              : '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.color_lens_outlined,
                        size: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('strColorTitle'.tr,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                          driver.vehicle != null
                              ? driver.vehicle!.color.capitalize!
                              : '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.credit_card_outlined,
                        size: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('strPlateNoTitle'.tr,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                          driver.vehicle != null
                              ? driver.vehicle!.plateNo.toString()
                              : '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                const ProfileControlsWidget(),
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

  void openPageLanding(bool isReferral, Configuration configuration) {
    Get.offAll(() => LandingPage(
          isReferral: isReferral,
          configuration: configuration,
        ));
  }

  void openSplash() {
    Get.offAll(() => SplashPage());
  }
}
