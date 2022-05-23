import 'package:equatable/equatable.dart';

class TokenData extends Equatable {
  final String access;

  const TokenData({
    required this.access,
  });

  @override
  List<Object?> get props => [
        access,
      ];
}
