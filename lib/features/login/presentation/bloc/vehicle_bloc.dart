import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_vehicle.dart';

import 'bloc.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final PostVehicle postVehicle;

  VehicleBloc({required this.postVehicle}) : super(VehicleInitial()) {
    on<VehicleEvent>(mapVehicleState);
  }

  Future<void> mapVehicleState(
    VehicleEvent event,
    Emitter<VehicleState> emit,
  ) async {
    if (event is GetVehicle) {
      print('LogHulu Vehicle: Add Request started');
      emit(LoadingVehicle());

      final failureOrSuccess =
          await postVehicle(Params(vehicle: event.vehicle));
      emit(failureOrSuccess.fold(
        (failure) {
          print('LogHulu Response error');
          return ErrorVehicle(message: _mapFailureToMessage(failure));
        },
        (success) {
          print('LogHulu Response received');
          return LoadedVehicle(driver: success);
        },
      ));
    }
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        if (failure is ServerFailure &&
            failure.errMsg != null &&
            failure.errMsg!.isNotEmpty) {
          return failure.errMsg!;
        } else {
          return AppConstants.errMsgServer;
        }
      case ConnectionFailure:
        return AppConstants.errMsgConnection;
      default:
        return AppConstants.errMsgUnknown;
    }
  }
}
