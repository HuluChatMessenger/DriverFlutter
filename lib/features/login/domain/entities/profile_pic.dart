import 'package:equatable/equatable.dart';

class ProfilePic extends Equatable {
  final int id;
  final String photo;

  const ProfilePic({
    required this.id,
    required this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        photo,
      ];
}
