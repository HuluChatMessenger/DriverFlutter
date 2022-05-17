import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent([List props = const <dynamic>[]]);
}

class GetMain extends MainEvent {
  const GetMain() : super();

  @override
  List<Object> get props => [];
}

class GetMainOnOffline extends MainEvent {
  final bool isSetOnline;

  GetMainOnOffline(this.isSetOnline) : super([isSetOnline]);

  @override
  List<Object> get props => [];
}

class GetMainPickup extends MainEvent {
  final String phoneNumber;
  final LatLng dropOffLatLng;

  GetMainPickup(this.phoneNumber, this.dropOffLatLng) : super([phoneNumber, dropOffLatLng]);

  @override
  List<Object> get props => [];
}

class GetMainAccept extends MainEvent {
  final bool isAccept;

  GetMainAccept(this.isAccept) : super([isAccept]);

  @override
  List<Object> get props => [];
}

class GetMainArrived extends MainEvent {
  final bool isArrived;

  GetMainArrived(this.isArrived) : super([isArrived]);

  @override
  List<Object> get props => [];
}

class GetMainStart extends MainEvent {
  GetMainStart() : super([]);

  @override
  List<Object> get props => [];
}

class GetMainDrivingComplete extends MainEvent {
  GetMainDrivingComplete() : super([]);

  @override
  List<Object> get props => [];
}
