import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/vehicle_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class AddPicPage extends StatelessWidget {
  String? pic;
  bool isValid = false;

  AddPicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<PicBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PicBloc>(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text(AppConstants.strAddPhotoTitle),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  backgroundTopCurveWidget(context),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 104, // Image radius
                              child: Image.asset(
                                  'assets/images/place_holder_profile.png'),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 24,
                              child: IconButton(
                                onPressed: () {
                                  if (pic != null) {
                                    addPic(context, pic!);
                                  }
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 64,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        const Text(
                          AppConstants.strAddPhotoSub,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 64),
                        MaterialButton(
                          onPressed: () {
                            if (isValid && pic != null) {
                              openPageVehicle();
                            } else {
                              return;
                            }
                          },
                          child: Container(
                            height: 50,
                            color: Colors.green,
                            child: Row(
                              children: const [
                                Text(
                                  AppConstants.strContinue,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          color: Colors.green,
                          disabledColor: Colors.grey.shade300,
                          textColor: Colors.white,
                          disabledTextColor: Colors.grey,
                          minWidth: MediaQuery.of(context).size.width - 100,
                          height: 44,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<PicBloc, PicState>(
            listener: (context, state) {
              if (state is LoadedPic) {
                isValid = true;
              }
            },
            builder: (context, state) {
              if (state is LoadingPic) {
                return const LoadingWidget();
              } else if (state is ErrorPic) {
                return DialogWidget(
                  message: state.message,
                  isDismiss: true,
                  typeDialog: AppConstants.dialogTypeErr,
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  void addPic(BuildContext context, String input) {
    FocusManager.instance.primaryFocus?.unfocus();
    BlocProvider.of<PicBloc>(context).add(GetPic(input));
  }

  void openPageVehicle() {
    Get.offAll(() => const VehiclePage());
  }

  void openPageSplash() {
    Get.offAll(() => const SplashPage());
  }
}
