import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:image_picker/image_picker.dart';
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
  XFile? selcetedPic;

  LoadingPic({this.selcetedPic});

  @override
  List<Object?> get props => [];
}

class LoadedPic extends PicState {
  final Configuration configuration;
  XFile? selcetedPic;

  LoadedPic({required this.configuration, this.selcetedPic});

  @override
  List<Object> get props => [];
}

class ErrorPic extends PicState {
  final String message;
  XFile? selcetedPic;

  ErrorPic({required this.message, this.selcetedPic});

  @override
  List<Object> get props => [];
}
