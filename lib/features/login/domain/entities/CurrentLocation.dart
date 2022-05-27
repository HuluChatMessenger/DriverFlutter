import 'dart:html';

import 'package:equatable/equatable.dart';

class CurrentLocation extends Equatable {
  final Location location;

  const CurrentLocation({
    required this.location,
  });

  @override
  List<Object?> get props => [
        location,
      ];
}
