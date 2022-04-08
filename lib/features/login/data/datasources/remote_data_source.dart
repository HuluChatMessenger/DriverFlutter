import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/features/login/data/models/login_model.dart';

abstract class RemoteDataSource {
  ///Calls the https://api.huluchat.com/huluride/auth.otp.send/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<LoginModel> getLoginOtp(String phoneNumber);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> getLoginOtp(String phoneNumber) async {
    final response = await client.post(
      Uri.parse('https://api.huluchat.com/huluride/auth.otp.send/'),
      headers: {'content-Type': 'application/json'},
      body: jsonEncode({'phonenumber': phoneNumber}),
    );

    if (response.statusCode == 201) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      print('Response exception: ' + response.statusCode.toString() + " | " + response.body);
      throw ServerException();
    }
  }
}
