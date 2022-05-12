import 'package:equatable/equatable.dart';
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
