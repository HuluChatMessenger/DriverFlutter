import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent([List props = const <dynamic>[]]);
}

class GetMain extends MainEvent {
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;

  GetMain(this.pickUpLatLng, this.destinationLatLng)
      : super([pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetTraffic extends MainEvent {
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  GetTraffic(this.isTraffic, this.pickUpLatLng, this.destinationLatLng)
      : super([isTraffic, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetConnectionState extends MainEvent {
  // final LatLng? currentLatLng;
  // final bool isTraffic;
  //
  // GetConnectionState(this.currentLatLng, this.isTraffic)
  //     : super([currentLatLng, isTraffic]);

  @override
  List<Object> get props => [];
}

class GetLocation extends MainEvent {
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;
  final bool isLocation;

  GetLocation(this.isTraffic, this.isLocation, this.pickUpLatLng,
      this.destinationLatLng)
      : super([isTraffic, isLocation, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainOnOffline extends MainEvent {
  final bool isSetOnline;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  GetMainOnOffline(this.isSetOnline, this.isTraffic, this.pickUpLatLng,
      this.destinationLatLng)
      : super([isSetOnline, isTraffic, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainPickup extends MainEvent {
  final String phoneNumber;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  GetMainPickup(this.phoneNumber, this.isTraffic, this.pickUpLatLng,
      this.destinationLatLng)
      : super([phoneNumber, isTraffic, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainAccept extends MainEvent {
  final bool isAccept;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  GetMainAccept(
      this.isAccept, this.isTraffic, this.pickUpLatLng, this.destinationLatLng)
      : super([isAccept, isTraffic, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainArrived extends MainEvent {
  final bool isArrived;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  GetMainArrived(
      this.isArrived, this.isTraffic, this.pickUpLatLng, this.destinationLatLng)
      : super([isArrived, isTraffic, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainStart extends MainEvent {
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  GetMainStart(
    this.isTraffic,
    this.pickUpLatLng,
    this.destinationLatLng,
  ) : super([isTraffic, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainDrivingComplete extends MainEvent {
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final bool isTraffic;

  GetMainDrivingComplete(
      this.isTraffic, this.pickUpLatLng, this.destinationLatLng)
      : super([isTraffic, pickUpLatLng, destinationLatLng]);

  @override
  List<Object> get props => [];
}
