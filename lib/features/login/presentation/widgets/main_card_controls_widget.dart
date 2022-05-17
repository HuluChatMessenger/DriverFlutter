import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/widgets/main_online_controls_widget.dart';

import 'widgets.dart';

class MainCardControlsWidget extends StatefulWidget {
  final Driver driver;
  String balance = '0.0';

  MainCardControlsWidget({Key? key, required this.driver}) : super(key: key);

  @override
  _MainCardControlsWidgetState createState() => _MainCardControlsWidgetState();
}

class _MainCardControlsWidgetState extends State<MainCardControlsWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(24, 24),
            topRight: Radius.elliptical(24, 24)),
        color: Colors.white,
      ),
      child: MainOnlineControlsWidget(driver: widget.driver,),
    );
  }
}
