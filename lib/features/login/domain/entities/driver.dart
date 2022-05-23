import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_wallet.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/profile_pic.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/token_data.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/vehicle.dart';

class Driver extends Equatable {
  final int id;
  final bool isApproved;
  final bool isContactConfirmed;
  bool isDocumentSubmitted = false;
  bool isPicSubmitted = false;
  bool isLoggedIn = false;
  final bool isActive;
  ProfilePic? profilePic;
  final String fName;
  final String mName;
  final String lName;
  final String email;
  final String phoneNumber;
  final String state;
  final int avgRating;
  final String userIdn;
  TokenData? tokenData;
  Vehicle? vehicle;
  final DriverWallet driverWallet;
  List<DriverDocuments>? driverDocuments;

  Driver({
    required this.id,
    required this.isApproved,
    required this.isContactConfirmed,
    required isDocumentSubmitted,
    required isPicSubmitted,
    required isLoggedIn,
    required this.isActive,
    this.profilePic,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.email,
    required this.phoneNumber,
    required this.state,
    required this.avgRating,
    required this.userIdn,
    this.tokenData,
    this.vehicle,
    required this.driverWallet,
    this.driverDocuments,
  });

  @override
  List<Object?> get props => [
        id,
        isApproved,
        isContactConfirmed,
        isDocumentSubmitted,
        isPicSubmitted,
        isLoggedIn,
        isActive,
        profilePic,
        fName,
        mName,
        lName,
        email,
        phoneNumber,
        state,
        avgRating,
        userIdn,
        tokenData,
        vehicle,
        driverWallet,
        driverDocuments,
      ];
}
