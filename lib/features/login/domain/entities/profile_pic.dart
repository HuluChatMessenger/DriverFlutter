import 'package:equatable/equatable.dart';

class ProfilePic extends Equatable {
  final int id;
  final String photo;
  final String photoAbsoluteUrl;

  const ProfilePic({
    required this.id,
    required this.photo,
    required this.photoAbsoluteUrl,
  });

  @override
  List<Object?> get props => [
        id,
        photo,
        photoAbsoluteUrl,
      ];
}
