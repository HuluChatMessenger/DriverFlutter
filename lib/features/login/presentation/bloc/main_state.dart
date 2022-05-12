import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainState extends Equatable {
  const MainState();
}

class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class EmptyMain extends MainState {
  @override
  List<Object?> get props => [];
}

class LoadingMain extends MainState {
  @override
  List<Object?> get props => [];
}

class LoadedMain extends MainState {
  final Driver driver;

  const LoadedMain({
    required this.driver,
  });

  @override
  List<Object> get props => [];
}

class ErrorMain extends MainState {
  final String message;

  const ErrorMain({required this.message});

  @override
  List<Object> get props => [];
}
