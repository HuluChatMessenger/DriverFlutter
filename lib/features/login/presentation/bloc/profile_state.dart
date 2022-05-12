import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/earning.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class EmptyProfile extends ProfileState {
  @override
  List<Object?> get props => [];
}

class LoadingProfile extends ProfileState {
  @override
  List<Object?> get props => [];
}

class LoadingProfileEarning extends ProfileState {
  @override
  List<Object?> get props => [];
}

class LoadedProfile extends ProfileState {
  final Driver driver;

  const LoadedProfile({required this.driver});

  @override
  List<Object> get props => [];
}

class LoadedProfileEarning extends ProfileState {
  final Earning earning;

  const LoadedProfileEarning({required this.earning});

  @override
  List<Object> get props => [];
}

class LogoutProfile extends ProfileState {
  final Configuration? configuration;

  const LogoutProfile({required this.configuration});

  @override
  List<Object> get props => [];
}

class ErrorProfile extends ProfileState {
  final String message;

  const ErrorProfile({required this.message});

  @override
  List<Object> get props => [];
}
