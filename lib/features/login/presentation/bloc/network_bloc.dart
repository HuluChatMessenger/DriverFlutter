import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'bloc.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitial()) {
    on<NetworkEvent>(mapNtkInitialState);
  }

  Future<void> mapNtkInitialState(
    NetworkEvent event,
    Emitter<NetworkState> emit,
  ) async {
    if (event is ListenConnection) {
      mapNetworkState(event);
    }
    if (event is ConnectionChanged) mapNetworkState(event);
  }

  StreamSubscription? _subscription;

  @override
  Stream<NetworkState> mapNetworkState(
    NetworkEvent event,
  ) async* {
    if (event is ListenConnection) {
      _subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == DataConnectionStatus.disconnected
            ? NetworkFailure()
            : NetworkSuccess()));
      });
    }

    if (event is ConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
