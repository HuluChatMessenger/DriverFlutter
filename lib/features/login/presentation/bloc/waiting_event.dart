import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class WaitingEvent extends Equatable {
  const WaitingEvent();
}

class GetWaiting extends WaitingEvent {

  const GetWaiting() : super();

  @override
  List<Object> get props => [];
}
