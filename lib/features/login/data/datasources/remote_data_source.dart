import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as multipartdio;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/features/login/data/models/configuration_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/driver_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/errors_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/login_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/pic_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/registration_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/errors.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/otp.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/registration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/constants.dart';

abstract class RemoteDataSource {
  ///Calls the https://api.huluchat.com/huluride/auth.otp.send/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<LoginModel> postLoginOtp(String phoneNumber);

  ///Calls the https://api.huluchat.com/huluride/register/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<RegistrationModel> postRegistrationOtp(Registration registration);

  ///Calls the https://api.huluchat.com/huluride/register.otp.verify/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DriverModel> postOtpRegistration(Otp otp);

  ///Calls the https://api.huluchat.com/huluride/auth/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DriverModel> postOtpLogin(Otp otp);

  ///Calls the https://api.huluchat.com/huluride/register/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DriverModel> postOtpResendRegistration(Registration registration);

  ///Calls the https://api.huluchat.com/huluride/photo.upload/ endpoint.
  ///
  /// Throws a [ServerException] & [LogoutException] for all error codes.
  Future<DriverModel> postPic(XFile pic);

  ///Calls the https://api.huluchat.com/huluride/driver/ endpoint.
  ///
  /// Throws a [ServerException] & [LogoutException] for all error codes.
  Future<DriverModel> putDriver(Driver driver);

  ///Calls the https://api.huluchat.com/huluride/driver/vehicle/ endpoint.
  ///
  /// Throws a [ServerException] & [LogoutException] for all error codes.
  Future<DriverModel> postVehicle(Vehicle vehicle);

  ///Calls the https://api.huluchat.com/huluride/driver/document/ endpoint.
  ///
  /// Throws a [ServerException] & [LogoutException] for all error codes.
  Future<DriverModel> postDocument(DriverDocuments document);

  ///Calls the https://api.huluchat.com/huluride/configurations/ endpoint.
  ///
  /// Throws [ServerException] & [EmptyException]  for all error codes.
  Future<ConfigurationModel> getConfiguration();

  ///Calls the https://api.huluchat.com/huluride/configurations/ endpoint.
  ///
  /// Throws [ServerException] & [EmptyException] & [LogoutException]  for all error codes.
  Future<ConfigurationModel> getConfigurationLogin();

  ///Calls the https://api.huluchat.com/huluride/driver/ endpoint.
  ///
  /// Throws [ServerException] & [EmptyException] & [LogoutException] for all error codes.
  Future<DriverModel> getDriver();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  RemoteDataSourceImpl({required this.client, required this.sharedPreferences});

  @override
  Future<RegistrationModel> postRegistrationOtp(
      Registration registration) async {
    var body = jsonEncode({
      'first_name': registration.firstName,
      'middle_name': registration.fatherName,
      'last_name': registration.grandfatherName,
      'phonenumber': registration.phoneNumber,
    });

    if (registration.referralCode != null &&
        registration.referralCode!.isNotEmpty) {
      body = jsonEncode({
        'first_name': registration.firstName,
        'middle_name': registration.fatherName,
        'last_name': registration.grandfatherName,
        'phonenumber': registration.phoneNumber,
        'referral_code': registration.referralCode,
      });
    }

    final response = await client.post(
      Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointRegister),
      headers: {'content-Type': 'application/json'},
      body: body,
    );

    print('LogHulu Response: ' +
        response.statusCode.toString() +
        " | " +
        response.body);

    if (response.statusCode == 201) {
      return RegistrationModel.fromJson(json.decode(response.body));
    } else {
      print('LogHulu RegistrationException: ' +
          response.statusCode.toString() +
          " | " +
          response.body);
      ServerException exception = ServerException(null);
      try {
        Errors errors = ErrorsModel.fromJson(json.decode(response.body));

        if (errors.nonFieldErrors.isNotEmpty) {
          exception = ServerException(errors.nonFieldErrors.first);
        } else {
          exception = ServerException(null);
        }
      } catch (e, s) {
        print('LogHulu ResponseExceptionRegistration: $e | $s');
        exception = ServerException(null);
      }
      throw exception;
    }
  }

  @override
  Future<LoginModel> postLoginOtp(String phoneNumber) async {
    final response = await client.post(
      Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointOtpLoginSend),
      headers: {'content-Type': 'application/json'},
      body: jsonEncode({'phonenumber': phoneNumber}),
    );

    print('LogHulu LoginResponse: ' +
        response.statusCode.toString() +
        " | " +
        response.body);

    if (response.statusCode == 201) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      print('LogHulu LoginException: ' +
          response.statusCode.toString() +
          " | " +
          response.body);
      ServerException exception = ServerException(null);
      try {
        Errors errors = ErrorsModel.fromJson(json.decode(response.body));

        if (errors.nonFieldErrors.isNotEmpty) {
          exception = ServerException(errors.nonFieldErrors.first);
        } else {
          exception = ServerException(null);
        }
      } catch (e, s) {
        print('LogHulu ResponseExceptionLogin: $e | $s');
        exception = ServerException(null);
      }
      throw exception;
    }
  }

  @override
  Future<DriverModel> postOtpLogin(Otp otp) async {
    final response = await client.post(
      Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointLogin),
      headers: {'content-Type': 'application/json'},
      body: jsonEncode({
        'otp': otp.otp,
        'phonenumber': otp.phoneNumber,
      }),
    );

    print('LogHulu OtpResponse: ' +
        response.statusCode.toString() +
        " | " +
        response.body);

    if (response.statusCode == 200) {
      return DriverModel.fromJson(json.decode(response.body));
    } else {
      print('LogHulu OTPException: ' +
          response.statusCode.toString() +
          " | " +
          response.body);
      ServerException exception = ServerException(null);
      try {
        Errors errors = ErrorsModel.fromJson(json.decode(response.body));

        if (errors.nonFieldErrors.isNotEmpty) {
          exception = ServerException(errors.nonFieldErrors.first);
        } else {
          exception = ServerException(null);
        }
      } catch (e, s) {
        print('LogHulu ResponseExceptionOTP: $e | $s');
        exception = ServerException(null);
      }
      throw exception;
    }
  }

  @override
  Future<DriverModel> postOtpRegistration(Otp otp) async {
    final response = await client.post(
      Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointOtpRegister),
      headers: {'content-Type': 'application/json'},
      body: jsonEncode({
        'otp': otp.otp,
        'user': otp.phoneNumber,
      }),
    );

    print('LogHulu Response: ' +
        response.statusCode.toString() +
        " | " +
        response.body);

    if (response.statusCode == 200) {
      return DriverModel.fromJson(json.decode(response.body));
    } else {
      print('LogHulu RegistrationOTPException: ' +
          response.statusCode.toString() +
          " | " +
          response.body);
      ServerException exception = ServerException(null);
      try {
        Errors errors = ErrorsModel.fromJson(json.decode(response.body));

        if (errors.nonFieldErrors.isNotEmpty) {
          exception = ServerException(errors.nonFieldErrors.first);
        } else {
          exception = ServerException(null);
        }
      } catch (e, s) {
        print('LogHulu ResponseExceptionOTPRegistration: $e | $s');
        exception = ServerException(null);
      }
      throw exception;
    }
  }

  @override
  Future<DriverModel> postPic(XFile pic) async {
    DriverModel? driverModel;
    final String? jsonDriver =
        sharedPreferences.getString(AppConstants.prefKeyDriver);
    if (jsonDriver != null) {
      driverModel = DriverModel.fromJson(json.decode(jsonDriver));
    }

    if (driverModel?.tokenData?.access != null) {
      int fileTypePosition = pic.name.indexOf('.') + 1;

      String fileType = pic.name.substring(fileTypePosition);

      print(
          'LogHulu type : ${pic.mimeType} === ${pic.runtimeType} === ${pic.name} === $fileType === ${pic.path}');

      String token = 'Token ${driverModel?.tokenData?.access}';

      var dio = Dio();

      dio.options.baseUrl = AppConstants.baseUrl;
      dio.options.headers = {
        'content-Type': 'application/json',
        'Authorization': token
      };

      var formData = FormData.fromMap({
        'photo': await multipartdio.MultipartFile.fromFile(pic.path,
            filename: pic.name, contentType: MediaType('image', fileType)),
      });

      dynamic uploadPicData;

      final response = await dio.post(
        '/${AppConstants.apiEndpointPic}',
        data: formData,
        onSendProgress: (int sent, int total) {
          print('LogHulu : $sent $total');
        },
      ).then((value) => {uploadPicData = value});

      ProfilePicModel? profilePicModel;

      try {
        profilePicModel =
            ProfilePicModel.fromJson(json.decode(uploadPicData.toString()));
        print('LogHulu UploadCheck: $profilePicModel');
      } catch (e) {
        print('LogHulu PicException: $e');
      }

      print('LogHulu Response: ' + uploadPicData.toString());

      if (profilePicModel != null && driverModel != null) {
        driverModel.profilePic = profilePicModel;
        print('LogHulu UploadDriverCheck: $driverModel  =====|||===== result');
        return driverModel;
      } else {
        print('LogHulu PicError: ' + uploadPicData);
        ServerException exception = ServerException(null);
        try {
          Errors errors = ErrorsModel.fromJson(uploadPicData);

          if (errors.nonFieldErrors.isNotEmpty) {
            exception = ServerException(errors.nonFieldErrors.first);
          } else {
            exception = ServerException(null);
          }
        } catch (e, s) {
          print('LogHulu ResponseExceptionDriver: $e | $s');
          exception = ServerException(null);
        }
        throw exception;
      }
    } else {
      throw LogoutException();
    }
  }

  @override
  Future<DriverModel> putDriver(Driver driver) async {
    if (driver.tokenData?.access != null) {
      String token = 'Token ${driver.tokenData?.access}';
      final body = jsonEncode({
        'id': driver.id,
        'is_approved': driver.isApproved,
        'contact_confirmed': driver.isContactConfirmed,
        'document_submited': driver.isDocumentSubmitted,
        'profile_picture': driver.profilePic?.id,
        'is_active': driver.isActive,
        'first_name': driver.fName,
        'middle_name': driver.mName,
        'last_name': driver.lName,
        'user_idn': driver.userIdn,
        'phonenumber': driver.phoneNumber,
        'state': driver.state,
        'token_data': driver.tokenData,
        'vehicle': driver.vehicle,
        'driver_wallet': driver.driverWallet,
        'driver_documents': driver.driverDocuments,
      });

      final response = await client.put(
        Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointDriver),
        headers: {'content-Type': 'application/json', 'Authorization': token},
        body: body,
      );

      print('LogHulu DriverUploadResponse: ' +
          response.statusCode.toString() +
          " | " +
          response.body);

      if (response.statusCode == 403) {
        throw LogoutException();
      } else if (response.statusCode == 200) {
        DriverModel resultDriver = DriverModel.fromJson(json.decode(response.body));
        resultDriver.isLoggedIn  = true;
        resultDriver.tokenData  = driver.tokenData;
        return resultDriver;
      } else {
        print('LogHulu DriverUploadException: ' +
            response.statusCode.toString() +
            " | " +
            response.body);
        ServerException exception = ServerException(null);
        try {
          Errors errors = ErrorsModel.fromJson(json.decode(response.body));

          if (errors.nonFieldErrors.isNotEmpty) {
            exception = ServerException(errors.nonFieldErrors.first);
          } else {
            exception = ServerException(null);
          }
        } catch (e, s) {
          print('LogHulu ResponseExceptionDriverUpload: $e | $s');
          exception = ServerException(null);
        }
        throw exception;
      }
    } else {
      throw LogoutException();
    }
  }

  @override
  Future<DriverModel> postVehicle(Vehicle vehicle) async {
    DriverModel? driverModel;
    final String? jsonDriver =
        sharedPreferences.getString(AppConstants.prefKeyDriver);
    if (jsonDriver != null) {
      driverModel = DriverModel.fromJson(json.decode(jsonDriver));
    }

    if (driverModel?.tokenData?.access != null) {
      String token = 'Token ${driverModel?.tokenData?.access}';
      final body = jsonEncode({
        'first_name': vehicle.color,
        'middle_name': vehicle.model,
        'last_name': vehicle.plateNo,
        'phonenumber': vehicle.makeYear,
      });

      final response = await client.post(
        Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointVehicle),
        headers: {'content-Type': 'application/json', 'Authorization': token},
        body: body,
      );

      print('LogHulu Response: ' +
          response.statusCode.toString() +
          " | " +
          response.body);

      if (response.statusCode == 403) {
        throw LogoutException();
      } else if (response.statusCode == 200) {
        return DriverModel.fromJson(json.decode(response.body));
      } else {
        print('LogHulu DriverException: ' +
            response.statusCode.toString() +
            " | " +
            response.body);
        ServerException exception = ServerException(null);
        try {
          Errors errors = ErrorsModel.fromJson(json.decode(response.body));

          if (errors.nonFieldErrors.isNotEmpty) {
            exception = ServerException(errors.nonFieldErrors.first);
          } else {
            exception = ServerException(null);
          }
        } catch (e, s) {
          print('LogHulu ResponseExceptionDriver: $e | $s');
          exception = ServerException(null);
        }
        throw exception;
      }
    } else {
      throw LogoutException();
    }
  }

  @override
  Future<DriverModel> postDocument(DriverDocuments document) async {
    DriverModel? driverModel;
    final String? jsonDriver =
        sharedPreferences.getString(AppConstants.prefKeyDriver);
    if (jsonDriver != null) {
      driverModel = DriverModel.fromJson(json.decode(jsonDriver));
    }

    if (driverModel?.tokenData?.access != null) {
      String token = 'Token ${driverModel?.tokenData?.access}';
      final body = jsonEncode({
        'first_name': document.id,
        'middle_name': document.documentType,
      });

      final response = await client.post(
        Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointDocument),
        headers: {'content-Type': 'application/json', 'Authorization': token},
        body: body,
      );

      print('LogHulu Response: ' +
          response.statusCode.toString() +
          " | " +
          response.body);

      if (response.statusCode == 403) {
        throw LogoutException();
      } else if (response.statusCode == 200) {
        return DriverModel.fromJson(json.decode(response.body));
      } else {
        print('LogHulu DriverException: ' +
            response.statusCode.toString() +
            " | " +
            response.body);
        ServerException exception = ServerException(null);
        try {
          Errors errors = ErrorsModel.fromJson(json.decode(response.body));

          if (errors.nonFieldErrors.isNotEmpty) {
            exception = ServerException(errors.nonFieldErrors.first);
          } else {
            exception = ServerException(null);
          }
        } catch (e, s) {
          print('LogHulu ResponseExceptionDriver: $e | $s');
          exception = ServerException(null);
        }
        throw exception;
      }
    } else {
      throw LogoutException();
    }
  }

  @override
  Future<ConfigurationModel> getConfiguration() async {
    final response = await client.get(
      Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointConfiguration),
      headers: {'content-Type': 'application/json'},
    );

    print('LogHulu Response: ' +
        response.statusCode.toString() +
        " | " +
        response.body);

    if (response.statusCode == 200) {
      return ConfigurationModel.fromJson(json.decode(response.body));
    } else {
      print('LogHulu ConfigurationException: ' +
          response.statusCode.toString() +
          " | " +
          response.body);
      ServerException exception = ServerException(null);
      try {
        Errors errors = ErrorsModel.fromJson(json.decode(response.body));

        if (errors.nonFieldErrors.isNotEmpty) {
          exception = ServerException(errors.nonFieldErrors.first);
        } else {
          exception = ServerException(null);
        }
      } catch (e, s) {
        print('LogHulu ResponseExceptionConfiguration: $e | $s');
        exception = ServerException(null);
      }
      throw exception;
    }
  }

  @override
  Future<ConfigurationModel> getConfigurationLogin() async {
    DriverModel? driverModel;
    final String? jsonDriver =
        sharedPreferences.getString(AppConstants.prefKeyDriver);
    if (jsonDriver != null) {
      driverModel = DriverModel.fromJson(json.decode(jsonDriver));
    }

    if (driverModel?.tokenData?.access != null) {
      String token = 'Token ${driverModel?.tokenData?.access}';
      final response = await client.get(
        Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointConfiguration),
        headers: {'content-Type': 'application/json', 'Authorization': token},
      );

      print('LogHulu Response: ' +
          response.statusCode.toString() +
          " | " +
          response.body);

      if (response.statusCode == 403) {
        throw LogoutException();
      } else if (response.statusCode == 200) {
        return ConfigurationModel.fromJson(json.decode(response.body));
      } else {
        print('LogHulu ConfigurationException: ' +
            response.statusCode.toString() +
            " | " +
            response.body);
        ServerException exception = ServerException(null);
        try {
          Errors errors = ErrorsModel.fromJson(json.decode(response.body));

          if (errors.nonFieldErrors.isNotEmpty) {
            exception = ServerException(errors.nonFieldErrors.first);
          } else {
            exception = ServerException(null);
          }
        } catch (e, s) {
          print('LogHulu ResponseExceptionConfiguration: $e | $s');
          exception = ServerException(null);
        }
        throw exception;
      }
    } else {
      throw EmptyException();
    }
  }

  @override
  Future<DriverModel> getDriver() async {
    DriverModel? driverModel;
    final String? jsonDriver =
        sharedPreferences.getString(AppConstants.prefKeyDriver);
    if (jsonDriver != null) {
      driverModel = DriverModel.fromJson(json.decode(jsonDriver));
    }

    print('LogHulu Chekc: $driverModel');

    if (driverModel?.tokenData?.access != null) {
      bool loginStatus = driverModel?.isLoggedIn == true;
      String token = 'Token ${driverModel?.tokenData?.access}';
      print('LogHulu $token');
      final response = await client.get(
        Uri.parse(AppConstants.baseUrl + AppConstants.apiEndpointDriver),
        headers: {'content-Type': 'application/json', 'Authorization': token},
      );

      print('LogHulu Response: ' +
          response.statusCode.toString() +
          " | " +
          response.body);

      if (response.statusCode == 403) {
        throw LogoutException();
      } else if (response.statusCode == 200) {
        DriverModel driverModelResult =
            DriverModel.fromJson(json.decode(response.body));

        if (loginStatus) {
          driverModelResult.isLoggedIn = loginStatus;
          driverModelResult.tokenData = driverModel?.tokenData;
        }

        return driverModelResult;
      } else {
        print('LogHulu DriverException: ' +
            response.statusCode.toString() +
            " | " +
            response.body);
        ServerException exception = ServerException(null);
        try {
          Errors errors = ErrorsModel.fromJson(json.decode(response.body));

          if (errors.nonFieldErrors.isNotEmpty) {
            exception = ServerException(errors.nonFieldErrors.first);
          } else {
            exception = ServerException(null);
          }
        } catch (e, s) {
          print('LogHulu ResponseExceptionDriver: $e | $s');
          exception = ServerException(null);
        }
        throw exception;
      }
    } else {
      throw EmptyException();
    }
  }

  @override
  Future<DriverModel> postOtpResendRegistration(
      Registration registration) async {
    final response = await client.post(
      Uri.parse(
          AppConstants.baseUrl + AppConstants.apiEndpointOtpRegisterResend),
      headers: {'content-Type': 'application/json'},
      body: jsonEncode({
        'id': registration.id,
        'phonenumber': registration.phoneNumber,
        'first_name': registration.firstName,
        'middle_name': registration.fatherName,
        'last_name': registration.grandfatherName,
      }),
    );

    print('LogHulu OtpResendResponse: ' +
        response.statusCode.toString() +
        " | " +
        response.body);

    if (response.statusCode == 200) {
      return DriverModel.fromJson(json.decode(response.body));
    } else {
      print('LogHulu OTPResendException: ' +
          response.statusCode.toString() +
          " | " +
          response.body);
      ServerException exception = ServerException(null);
      try {
        Errors errors = ErrorsModel.fromJson(json.decode(response.body));

        if (errors.nonFieldErrors.isNotEmpty) {
          exception = ServerException(errors.nonFieldErrors.first);
        } else {
          exception = ServerException(null);
        }
      } catch (e, s) {
        print('LogHulu ResponseExceptionOTPResend: $e | $s');
        exception = ServerException(null);
      }
      throw exception;
    }
  }
}
