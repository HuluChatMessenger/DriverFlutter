import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PicState extends Equatable {
  const PicState();
}

class PicInitial extends PicState {
  @override
  List<Object> get props => [];
}

class EmptyPic extends PicState {
  @override
  List<Object?> get props => [];
}

class LoadingPic extends PicState {
  @override
  List<Object?> get props => [];
}

class LoadedPic extends PicState {
  final Driver driver;

  const LoadedPic({required this.driver});

  @override
  List<Object> get props => [];
}

class ErrorPic extends PicState {
  final String message;

  const ErrorPic({required this.message});

  @override
  List<Object> get props => [];
}
