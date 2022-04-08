import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/login_bloc.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../widgets/widgets.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
              onPressed: () {},
            );
          },
        ),
        title: Text('Back'),
      ),
      body: SingleChildScrollView(
        child: Center(child: Text('Landing Page'),),
      ),
    );
  }
}
