import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String> nonFieldErrors;

  const Errors({required this.nonFieldErrors});

  @override
  List<Object?> get props => [nonFieldErrors];
}
