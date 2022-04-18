import 'package:equatable/equatable.dart';

class TokenData extends Equatable {
  final String refresh;
  final String access;

  const TokenData({
    required this.refresh,
    required this.access,
  });

  @override
  List<Object?> get props => [
        refresh,
        access,
      ];
}
