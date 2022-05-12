import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent([List props = const <dynamic>[]]);
}

class GetProfile extends ProfileEvent {
  const GetProfile() : super();

  @override
  List<Object> get props => [];
}

class GetProfileLogout extends ProfileEvent {
  const GetProfileLogout() : super();

  @override
  List<Object> get props => [];
}

class GetProfileEarning extends ProfileEvent {
  const GetProfileEarning() : super();

  @override
  List<Object> get props => [];
}
