import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';

import '../../domain/entities/driver.dart';

@immutable
abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class EmptySplash extends SplashState {
  @override
  List<Object?> get props => [];
}

class LoadingSplash extends SplashState {
  @override
  List<Object?> get props => [];
}

class LoadedLandingSplash extends SplashState {
  final Configuration configuration;

  const LoadedLandingSplash({required this.configuration});

  @override
  List<Object> get props => [];
}

class LoadedPicSplash extends SplashState {
  final Driver driver;

  const LoadedPicSplash({required this.driver});

  @override
  List<Object> get props => [];
}

class LoadedVehicleSplash extends SplashState {
  final Configuration configuration;

  const LoadedVehicleSplash({required this.configuration});

  @override
  List<Object> get props => [];
}

class LoadedDocumentsSplash extends SplashState {
  final Configuration configuration;
  final List<DriverDocuments> documents;

  const LoadedDocumentsSplash({required this.configuration, required this.documents});

  @override
  List<Object> get props => [];
}

class LoadedWaitingSplash extends SplashState {
  final Driver driver;

  const LoadedWaitingSplash({required this.driver});

  @override
  List<Object> get props => [];
}

class LoadedLoginSplash extends SplashState {
  final Driver driver;

  const LoadedLoginSplash({required this.driver});

  @override
  List<Object> get props => [];
}

class ErrorSplash extends SplashState {
  final String message;

  const ErrorSplash({required this.message});

  @override
  List<Object> get props => [];
}
