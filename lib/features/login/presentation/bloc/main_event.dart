import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent([List props = const <dynamic>[]]);
}

class GetMain extends MainEvent {
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetMain(this.currentLatLng, this.isTraffic) : super([currentLatLng, isTraffic]);

  @override
  List<Object> get props => [];
}

class GetTraffic extends MainEvent {
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetTraffic(this.currentLatLng, this.isTraffic) : super([currentLatLng, isTraffic]);

  @override
  List<Object> get props => [];
}

class GetMainOnOffline extends MainEvent {
  final bool isSetOnline;
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetMainOnOffline(this.isSetOnline, this.currentLatLng, this.isTraffic)
      : super([isSetOnline, currentLatLng, isTraffic]);

  @override
  List<Object> get props => [];
}

class GetMainPickup extends MainEvent {
  final String phoneNumber;
  final LatLng dropOffLatLng;
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetMainPickup(this.phoneNumber, this.dropOffLatLng, this.currentLatLng, this.isTraffic)
      : super([phoneNumber, dropOffLatLng, currentLatLng, isTraffic]);

  @override
  List<Object> get props => [];
}

class GetMainAccept extends MainEvent {
  final bool isAccept;
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetMainAccept(this.isAccept, this.currentLatLng, this.isTraffic)
      : super([isAccept, currentLatLng, isTraffic]);

  @override
  List<Object> get props => [];
}

class GetMainArrived extends MainEvent {
  final bool isArrived;
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetMainArrived(this.isArrived, this.currentLatLng, this.isTraffic)
      : super([isArrived, currentLatLng, isTraffic]);

  @override
  List<Object> get props => [];
}

class GetMainStart extends MainEvent {
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetMainStart(this.currentLatLng, this.isTraffic) : super([currentLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainDrivingComplete extends MainEvent {
  final LatLng? currentLatLng;
  final bool isTraffic;

  GetMainDrivingComplete(this.currentLatLng, this.isTraffic) : super([currentLatLng]);

  @override
  List<Object> get props => [];
}
