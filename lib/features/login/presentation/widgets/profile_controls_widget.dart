import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';

class ProfileControlsWidget extends StatefulWidget {
  const ProfileControlsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileControlsWidgetState createState() => _ProfileControlsWidgetState();
}

class _ProfileControlsWidgetState extends State<ProfileControlsWidget> {
  _ProfileControlsWidgetState() {
    Future.delayed(const Duration(microseconds: 15), () {
      addEarning();
      addDriver();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void addDriver() {
    BlocProvider.of<ProfileBloc>(context).add(GetProfile());
  }

  void addEarning() {
    BlocProvider.of<ProfileBloc>(context).add(GetProfileEarning());
  }
}
