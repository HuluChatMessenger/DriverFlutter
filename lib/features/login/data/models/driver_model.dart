import 'package:hulutaxi_driver/features/login/data/models/document_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/pic_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/token_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/vehicle_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/wallet_model.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_wallet.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/profile_pic.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/token_data.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';

class DriverModel extends Driver {
  DriverModel({
    required id,
    required isApproved,
    required isContactConfirmed,
    isDocumentSubmitted,
    isPicSubmitted,
    isLoggedIn,
    required isActive,
    profilePic,
    required fName,
    required mName,
    required lName,
    required email,
    required phoneNumber,
    required state,
    required avgRating,
    required userIdn,
    tokenData,
    vehicle,
    required driverWallet,
    driverDocuments,
  }) : super(
          id: id,
          isApproved: isApproved,
          isContactConfirmed: isContactConfirmed,
          isDocumentSubmitted: isDocumentSubmitted,
          isPicSubmitted: isPicSubmitted,
          isLoggedIn: isLoggedIn,
          isActive: isActive,
          profilePic: profilePic,
          fName: fName,
          mName: mName,
          lName: lName,
          email: email,
          phoneNumber: phoneNumber,
          state: state,
          avgRating: avgRating,
          userIdn: userIdn,
          tokenData: tokenData,
          vehicle: vehicle,
          driverWallet: driverWallet,
          driverDocuments: driverDocuments,
        );

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    DriverWallet driverWallet =
        DriverWalletModel.fromJson(json['driver_wallet']);

    print('LogHulu CheckWallet: $driverWallet');

    TokenData? token;
    var tokenData = json['token_data'];

    if (tokenData != null) {
      token = TokenDataModel.fromJson(json['token_data']);
    }

    print('LogHulu CheckToken: $tokenData');

    ProfilePic? profilePic;
    var profilePicData = json['profile_picture'];

    if (profilePicData != null)
      profilePic = ProfilePicModel.fromJson(profilePicData);

    print('LogHulu CheckPic: $profilePic');

    Vehicle? vehicle;
    var vehicleData = json['vehicle'];

    if (vehicleData != null) vehicle = VehicleModel.fromJson(vehicleData);

    print('LogHulu CheckVehicle: $vehicle');

    var driverDocumentsFromJson = json['driver_documents'];
    List<DriverDocuments> driverDocumentsList = [];
    for (dynamic element in driverDocumentsFromJson) {
      DriverDocuments document = DriverDocumentsModel.fromJson(element);
      driverDocumentsList.add(document);
    }
    print('LogHulu CheckDoc: $driverDocumentsList');

    bool isPicSubmitted = false;

    if (profilePic?.photo != null) {
      isPicSubmitted = true;
    }

    print('LogHulu Pic: $isPicSubmitted');
    DriverModel driverModel = DriverModel(
      id: json['id'],
      isApproved: json['is_approved'],
      isContactConfirmed: json['contact_confirmed'],
      isDocumentSubmitted: json['document_submited'],
      isActive: json['is_active'],
      isLoggedIn: json['is_logged_in'],
      isPicSubmitted: isPicSubmitted,
      profilePic: profilePic,
      fName: json['first_name'],
      mName: json['middle_name'],
      lName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phonenumber'],
      state: json['state'],
      avgRating: json['avg_rating'],
      userIdn: json['user_idn'],
      tokenData: token,
      vehicle: vehicle,
      driverWallet: driverWallet,
      driverDocuments: driverDocumentsList,
    );
    driverModel.isPicSubmitted = isPicSubmitted == true;
    print('LogHulu json: $driverModel');
    return driverModel;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_approved': isApproved,
      'contact_confirmed': isContactConfirmed,
      'document_submited': isDocumentSubmitted,
      'is_active': isActive,
      'is_logged_in': isLoggedIn,
      'profile_picture': profilePic,
      'first_name': fName,
      'middle_name': mName,
      'last_name': lName,
      'email': email,
      'phonenumber': phoneNumber,
      'state': state,
      'avg_rating': avgRating,
      'user_idn': userIdn,
      'token_data': tokenData,
      'vehicle': vehicle,
      'driver_wallet': driverWallet,
      'driver_documents': driverDocuments,
    };
  }
}
