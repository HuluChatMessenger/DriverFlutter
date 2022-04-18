import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SplashEvent extends Equatable {
  const SplashEvent([List props = const <dynamic>[]]);
}

class GetSplash extends SplashEvent {

  const GetSplash() : super();

  @override
  List<Object> get props => [];
}
